import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_finder_app/core/utils/debounceAndRestartable/debound_and_restartable.dart';
import 'package:image_finder_app/core/utils/error/failure.dart';
import 'package:image_finder_app/core/utils/status_enum/status_enum.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/features/home/domain/entities/search_entity.dart';
import 'package:image_finder_app/features/home/domain/usecases/cached_random_photo_usecase.dart';
import 'package:image_finder_app/features/home/domain/usecases/get_cached_random_usecase.dart';
import 'package:image_finder_app/features/home/domain/usecases/get_random_photo_usecase.dart';
import 'package:image_finder_app/features/home/domain/usecases/seatch_photo_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRandomPhotoUsecase getRandomPhotoUsecase;
  final SearchPhotoUsecase searchPhotoUsecase;

  final GetCachedRandomUsecase getCachedRandomUsecase;
  final CachedRandomPhotoUsecase cachedRandomPhotoUsecase;

  HomeBloc({
    required this.getRandomPhotoUsecase,
    required this.searchPhotoUsecase,
    required this.getCachedRandomUsecase,
    required this.cachedRandomPhotoUsecase,
  }) : super(HomeState()) {
    on<GetRandomPhotosEvent>(_onGetRandomPhotos);
    on<SearchPhotoEvent>(
      _onSearchPhoto,
      transformer: debounceAndRestartble<SearchPhotoEvent>(
        const Duration(milliseconds: 1000),
      ),
    );
    on<PullToRefreshEvent>(_onPullToRefresh);
    on<GetMorePhotoEvent>(
      _onGetMorePhoto,
      transformer: droppable(),
    );
  }

  void _onGetRandomPhotos(
    GetRandomPhotosEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: StatusEnum.loading));

    final response = await getRandomPhotoUsecase.call();

    response.fold((l) {
      emit(state.copyWith(
        error: l,
        status: StatusEnum.error,
      ));
    }, (r) async {
      emit(state.copyWith(
        photo: r,
        status: StatusEnum.successfulll,
      ));

      await cachedRandomPhotoUsecase.call(params: r);
    });

    event.completer?.complete();
  }

  void _onSearchPhoto(SearchPhotoEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      status: StatusEnum.loading,
      searchValue: event.value,
      canLoadMore: true,
      page: 1,
    ));

    if (state.searchIsEmpty) {
      final response = await getCachedRandomUsecase.call();

      emit(state.copyWith(
        photo: response,
        status: StatusEnum.successfulll,
      ));
    } else {
      final response = await searchPhotoUsecase.call(
        params: SearchEntity(
          value: event.value,
          page: state.page,
          perPage: state.perPage,
        ),
      );

      response.fold((l) {
        emit(state.copyWith(
          error: l,
          status: StatusEnum.error,
        ));
      }, (r) {
        emit(state.copyWith(
          photo: r,
          status: StatusEnum.successfulll,
        ));
      });
    }

    event.completer?.complete();
  }

  void _onPullToRefresh(
    PullToRefreshEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.searchIsEmpty) {
      add(GetRandomPhotosEvent(
        completer: event.completer,
      ));
    } else {
      add(SearchPhotoEvent(
        value: state.searchValue,
        completer: event.completer,
      ));
    }
  }

  void _onGetMorePhoto(
    GetMorePhotoEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.loadingMore == StatusEnum.loading) {
      return;
    }

    emit(state.copyWith(
      loadingMore: StatusEnum.loading,
      page: state.page + 1,
    ));

    final response = await searchPhotoUsecase.call(
      params: SearchEntity(
        value: state.searchValue,
        page: state.page,
        perPage: state.perPage,
      ),
    );

    response.fold((l) {}, (r) {
      if (r.length < state.perPage) {
        emit(state.copyWith(
          canLoadMore: false,
        ));
      }

      emit(state.copyWith(
        photo: [
          ...state.photo ?? [],
          ...r,
        ],
        loadingMore: StatusEnum.successfulll,
      ));
    });

    emit(state.copyWith(loadingMore: StatusEnum.initial));
  }
}
