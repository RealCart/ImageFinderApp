import 'package:get_it/get_it.dart';
import 'package:image_finder_app/core/data/sources/locale/favorites_locale.dart';
import 'package:image_finder_app/core/data/sources/locale/sqflite_client.dart';
import 'package:image_finder_app/core/data/sources/remote/dio_client.dart';
import 'package:image_finder_app/features/favorities/data/repositories/favorities_repository_impl.dart';
import 'package:image_finder_app/features/favorities/domain/repositories/favorities_repository.dart';
import 'package:image_finder_app/features/favorities/domain/usecases/get_favorities_usecase.dart';
import 'package:image_finder_app/features/favorities/presentation/bloc/favorities_bloc/favorities_bloc.dart';
import 'package:image_finder_app/features/photo/data/sources/locale/photo_locale.dart';
import 'package:image_finder_app/features/photo/data/repositories/photo_repository_impl.dart';
import 'package:image_finder_app/features/photo/domain/repositories/photo_repository.dart';
import 'package:image_finder_app/features/photo/domain/usecases/add_to_favorites_usecase.dart';
import 'package:image_finder_app/features/photo/domain/usecases/download_photo_usecase.dart';
import 'package:image_finder_app/features/photo/domain/usecases/is_favorite_usecase.dart';
import 'package:image_finder_app/features/photo/domain/usecases/remove_from_favorites_usecase.dart';
import 'package:image_finder_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:image_finder_app/features/home/data/sources/locale/home_locale.dart';
import 'package:image_finder_app/features/home/data/sources/remote/home_remote.dart';
import 'package:image_finder_app/features/home/domain/repositories/home_repository.dart';
import 'package:image_finder_app/features/home/domain/usecases/cached_random_photo_usecase.dart';
import 'package:image_finder_app/features/home/domain/usecases/get_cached_random_usecase.dart';
import 'package:image_finder_app/features/home/domain/usecases/get_random_photo_usecase.dart';
import 'package:image_finder_app/features/home/domain/usecases/seatch_photo_usecase.dart';
import 'package:image_finder_app/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:image_finder_app/features/photo/presentation/bloc/photo_bloc/photo_bloc.dart';

final sl = GetIt.I;

void serviceLoactor() {
  // Core remote sources
  sl.registerLazySingleton<DioClient>(() => DioClient());

  //Core locale sources
  sl.registerSingletonAsync<SqfliteClient>(() async {
    final dbInstance = SqfliteClient();
    await dbInstance.db;
    return dbInstance;
  });

  //Feature Remote sources
  sl.registerLazySingleton<HomeRemote>(() => HomeRemoteImpl(sl<DioClient>()));

  //Feature Locale sources
  sl.registerLazySingleton<HomeLocale>(
    () => HomeLocaleImpl(sl<SqfliteClient>()),
  );

  sl.registerLazySingleton<FavoritesLocale>(
    () => FavoritesLocaleImpl(sl<SqfliteClient>()),
  );

  sl.registerLazySingleton<PhotoLocale>(
    () => PhotoLocaleImpl(sl<SqfliteClient>()),
  );

  //Feature Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remote: sl<HomeRemote>(),
      locale: sl<HomeLocale>(),
    ),
  );

  sl.registerLazySingleton<PhotoRepository>(
    () => PhotoRepositoryImpl(
      locale: sl<PhotoLocale>(),
    ),
  );

  sl.registerLazySingleton<FavoritiesRepository>(
    () => FavoritiesRepositoryImpl(
      locale: sl<FavoritesLocale>(),
    ),
  );

  //Feature Use Cases
  sl.registerLazySingleton<GetRandomPhotoUsecase>(
    () => GetRandomPhotoUsecase(sl<HomeRepository>()),
  );

  sl.registerLazySingleton<SearchPhotoUsecase>(
    () => SearchPhotoUsecase(sl<HomeRepository>()),
  );

  sl.registerLazySingleton<CachedRandomPhotoUsecase>(
    () => CachedRandomPhotoUsecase(sl<HomeRepository>()),
  );

  sl.registerLazySingleton<GetCachedRandomUsecase>(
    () => GetCachedRandomUsecase(sl<HomeRepository>()),
  );

  sl.registerLazySingleton<IsFavoriteUseCase>(
    () => IsFavoriteUseCase(sl<PhotoRepository>()),
  );

  sl.registerLazySingleton<AddToFavoritesUseCase>(
    () => AddToFavoritesUseCase(sl<PhotoRepository>()),
  );

  sl.registerLazySingleton<RemoveFromFavoritesUseCase>(
    () => RemoveFromFavoritesUseCase(sl<PhotoRepository>()),
  );

  sl.registerLazySingleton<DownloadPhotoUseCase>(
    () => DownloadPhotoUseCase(sl<PhotoRepository>()),
  );

  sl.registerLazySingleton<GetFavoritiesUsecase>(
    () => GetFavoritiesUsecase(sl<FavoritiesRepository>()),
  );

  //Feature Blocs
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getRandomPhotoUsecase: sl<GetRandomPhotoUsecase>(),
      searchPhotoUsecase: sl<SearchPhotoUsecase>(),
      cachedRandomPhotoUsecase: sl<CachedRandomPhotoUsecase>(),
      getCachedRandomUsecase: sl<GetCachedRandomUsecase>(),
    ),
  );

  sl.registerFactory<PhotoBloc>(
    () => PhotoBloc(
      isFavoriteUseCase: sl<IsFavoriteUseCase>(),
      addToFavoritesUseCase: sl<AddToFavoritesUseCase>(),
      removeFromFavoritesUseCase: sl<RemoveFromFavoritesUseCase>(),
      downloadPhotoUseCase: sl<DownloadPhotoUseCase>(),
    ),
  );

  sl.registerFactory<FavoritiesBloc>(
    () => FavoritiesBloc(
      getFavoritiesUsecase: sl<GetFavoritiesUsecase>(),
    ),
  );
}
