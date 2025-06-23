import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_finder_app/core/domain/entities/photo/photo_entity.dart';
import 'package:image_finder_app/core/utils/status_enum/status_enum.dart';
import 'package:image_finder_app/features/favorities/domain/usecases/get_favorities_usecase.dart';

part 'favorities_event.dart';
part 'favorities_state.dart';

class FavoritiesBloc extends Bloc<FavoritiesEvent, FavoritiesState> {
  final GetFavoritiesUsecase getFavoritiesUsecase;

  FavoritiesBloc({
    required this.getFavoritiesUsecase,
  }) : super(const FavoritiesState()) {
    on<GetFavoritiesEvent>(_onGetFavorities);
  }

  _onGetFavorities(
    GetFavoritiesEvent event,
    Emitter<FavoritiesState> emit,
  ) async {
    emit(state.copyWith(status: StatusEnum.loading));
    final favorities = await getFavoritiesUsecase(params: null);
    emit(state.copyWith(
      status: StatusEnum.successfulll,
      favorities: favorities,
    ));
    event.completer?.complete();
  }
}
