import 'package:get_it/get_it.dart';
import 'package:image_processing_ai_tool/data/datasource_services/bg_remove_service.dart';
import 'package:image_processing_ai_tool/data/datasource_services/check_connectivity_service.dart';
import 'package:image_processing_ai_tool/data/datasource_services/image_downloader.dart';
import 'package:image_processing_ai_tool/data/datasource_services/image_picker_service.dart';
import 'package:image_processing_ai_tool/data/datasource_services/image_saving_service.dart';
import 'package:image_processing_ai_tool/data/datasource_services/upscale_service.dart';
import 'package:image_processing_ai_tool/data/datasources/local/image_saver_datasource.dart';
import 'package:image_processing_ai_tool/data/datasources/local/login_local_datasource.dart';
import 'package:image_processing_ai_tool/data/datasources/local/remote/bgRemover.dart'; // safdsdfgdg
import 'package:image_processing_ai_tool/data/datasources/local/remote/conectivity_checker_datasource.dart';
import 'package:image_processing_ai_tool/data/datasources/local/remote/key_validation_check_datasource.dart';
import 'package:image_processing_ai_tool/data/datasources/local/remote/upscaler_datasource.dart';
import 'package:image_processing_ai_tool/data/datasources/local/remove_bg_image_picker.dart';
import 'package:image_processing_ai_tool/data/datasources/local/save_local_key_datasource.dart';
import 'package:image_processing_ai_tool/data/datasources/local/upscale_image_picker.dart';
import 'package:image_processing_ai_tool/data/repositories/conectivity_repo_impl.dart';
import 'package:image_processing_ai_tool/data/repositories/image_processing_repo_impl.dart';
import 'package:image_processing_ai_tool/data/repositories/login_repository/is_valid_key_repository_impl.dart';
import 'package:image_processing_ai_tool/data/repositories/login_repository/key_save_repository_impl.dart';
import 'package:image_processing_ai_tool/data/repositories/login_repository/login_repository_impl.dart';
import 'package:image_processing_ai_tool/domain/repositories/connectivity_repo.dart';
import 'package:image_processing_ai_tool/domain/repositories/image_processing_repo.dart';
import 'package:image_processing_ai_tool/domain/repositories/login_repository/is_valid_key_repository.dart';
import 'package:image_processing_ai_tool/domain/repositories/login_repository/key_save_repository.dart';
import 'package:image_processing_ai_tool/domain/repositories/login_repository/login_repository.dart';
import 'package:image_processing_ai_tool/domain/usecases/bg_removed_image_save_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/connectivity.dart';
import 'package:image_processing_ai_tool/domain/usecases/login_usecases/check_user_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/login_usecases/is_valid_api_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/login_usecases/save_api_key_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/remove_bg_pick_image_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/remove_bg_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/upscale_image_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/upscale_pick_image_usecase.dart';
import 'package:image_processing_ai_tool/domain/usecases/upscaled_image_save_usecase.dart';
import 'package:image_processing_ai_tool/presentation/state/auth_state/auth_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/image_processing_bloc.dart';
import 'package:image_processing_ai_tool/presentation/state/network_checking_bloc.dart';

final getIt = GetIt.instance;

void init() {
  //bloc
  getIt.registerFactory(() => ImageProcessingBloc(
      upscaledImageSaveUsecase: getIt(),
      upscaleImageUsecase: getIt(),
      bgRemovedImageSaveUsecase: getIt(),
      removeBgUsecase: getIt(),
      removeBgPickImageUsecase: getIt()));
  getIt
      .registerFactory(() => NetworkCheckingBloc(connectivityUsecase: getIt()));

  getIt.registerFactory(() => AuthBloc(
      checkUserStatus: getIt(),
      isValidApiUsecase: getIt(),
      saveApiKeyUsecase: getIt()));

  //uscases
  getIt.registerLazySingleton(
      () => ConnectivityUsecase(conectivityRepo: getIt()));
  getIt.registerLazySingleton(
      () => RemoveBgPickImageUsecase(imageProcessingRepo: getIt()));
  getIt.registerLazySingleton(
      () => RemoveBgUsecase(imageProcessingRepo: getIt()));
  getIt.registerLazySingleton(
      () => BgRemovedImageSaveUsecase(imageProcessingRepo: getIt()));
  getIt.registerLazySingleton(
      () => UpscalePickImageUsecase(imageProcessingRepo: getIt()));
  getIt.registerLazySingleton(
      () => UpscaleImageUsecase(imageProcessingRepo: getIt()));
  getIt.registerLazySingleton(
      () => UpscaledImageSaveUsecase(imageProcessingRepo: getIt()));
  //
  getIt.registerLazySingleton(() => CheckUserUsecase(loginRepository: getIt()));
  getIt.registerLazySingleton(
      () => IsValidApiUsecase(isValidKeyRepository: getIt()));
  getIt.registerLazySingleton(
      () => SaveApiKeyUsecase(keySaveRepository: getIt()));

  //repo
  getIt.registerLazySingleton<ConectivityRepo>(
      () => ConectivityRepoImpl(conectivityCheckerDatasource: getIt()));
  getIt.registerLazySingleton<ImageProcessingRepo>(() =>
      ImageProcessingRepoImpl(
          upscalerDatasource: getIt(),
          upscaleImagePicker: getIt(),
          imageSaverDatasource: getIt(),
          removeBgImagePicker: getIt(),
          bgremover: getIt()));
  //
  getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(localDatasource: getIt()));

  getIt.registerLazySingleton<IsValidKeyRepository>(
      () => IsValidKeyRepositoryImpl(keyValidationCheckDatasource: getIt()));
  getIt.registerLazySingleton<KeySaveRepository>(
      () => KeySaveRepositoryImpl(saveLocalKeyDatasource: getIt()));

  //datasources
  getIt.registerLazySingleton(
      () => ConectivityCheckerDatasource(conectivityService: getIt()));
  getIt.registerLazySingleton(
      () => RemoveBgImagePicker(imagePickerService: getIt()));

  getIt.registerLazySingleton(
      () => Bgremover(bgRemoveService: getIt(), imageDownloader: getIt()));
  getIt.registerLazySingleton(
      () => ImageSaverDatasource(imageSavingService: getIt()));
  getIt.registerLazySingleton(
      () => UpscaleImagePicker(imagePickerService: getIt()));
  getIt.registerLazySingleton(() =>
      UpscalerDatasource(imageDownloader: getIt(), upscaleService: getIt()));
//
  getIt.registerLazySingleton(() => LoginLocalDatasource());
  getIt.registerLazySingleton(() => KeyValidationCheckDatasource());
  getIt.registerLazySingleton(() => SaveLocalKeyDatasource());
  // services
  getIt.registerLazySingleton(() => CheckConnectivityService());
  getIt.registerLazySingleton(() => ImagePickerService());
  getIt.registerLazySingleton(() => BgRemoveService());
  getIt.registerLazySingleton(() => ImageDownloader());
  getIt.registerLazySingleton(() => ImageSavingService());
  getIt.registerLazySingleton(() => UpscaleService());
}
