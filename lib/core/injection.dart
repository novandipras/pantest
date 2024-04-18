import 'package:pantest/lib.dart';

final injection = GetIt.instance;

void injectionInit() {
  initModuleInjection();
  initExternal();
}

Future<void> initExternal() async {
  injection.registerLazySingleton<Dio>(
    () => Dio(),
  );
  injection.registerLazySingleton<SqfliteService>(
    () => SqfliteService(),
  );
}

Future<void> initModuleInjection() async {
  /// BLOC
  injection.registerFactory(
    () => HomeNavbarBloc(),
  );
  injection.registerFactory(
    () => ExploreBloc(
      injection(),
    ),
  );
  injection.registerFactory(
    () => ListUserBloc(
      injection(),
    ),
  );  injection.registerFactory(
    () => LikesPostBloc(
      injection(),
    ),
  );
  injection.registerFactory(
    () => ProfileBloc(
      injection(),
    ),
  );
  injection.registerFactory(
    () => PostingOnProfileBloc(
      injection(),
    ),
  );

  /// USECASE
  injection.registerLazySingleton(
    () => SocialMediaUsecase(
      injection(),
    ),
  );

  /// REPOSITORY
  injection.registerLazySingleton<SocialMediaRepository>(
    () => SocialMediaRepositoryImpl(
      socialMediaDatasource: injection(),
    ),
  );

  /// DATASOURCE
  injection.registerLazySingleton<SocialMediaDatasource>(
    () => SocialMediaDatasourceImpl(),
  );
}
