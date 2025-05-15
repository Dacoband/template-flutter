import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_cart_test/core/config/env.dart';
import 'package:stream_cart_test/core/network/auth_interceptor.dart';
import 'package:stream_cart_test/core/routing/app_router.dart';
import 'package:stream_cart_test/core/services/auth_service.dart';
import 'package:stream_cart_test/core/services/storage_service.dart';
import 'package:stream_cart_test/data/datasources/remote_data_source.dart';
import 'package:stream_cart_test/data/repositories/auth_repository_impl.dart';
import 'package:stream_cart_test/domain/usecases/login_usecase.dart';
import 'package:stream_cart_test/domain/usecases/signup_usecase.dart';
import 'package:stream_cart_test/presentation/blocs/auth/auth_bloc.dart';
import 'package:stream_cart_test/presentation/pages/login_page.dart';
import 'package:stream_cart_test/presentation/pages/signup_page.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Register core services
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<StorageService>(StorageService(getIt<FlutterSecureStorage>()));
  
  // Register network
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<AuthService>(AuthService(getIt<Dio>(), getIt<StorageService>()));
  
  // Register auth interceptor
  final authInterceptor = AuthInterceptor(getIt<AuthService>(), getIt<Dio>());
  getIt<Dio>().interceptors.add(authInterceptor);
  
  // Register data sources
  getIt.registerSingleton<RemoteDataSource>(RemoteDataSource(getIt<Dio>(), getIt<AuthService>()));
  
  // Register repositories
  getIt.registerSingleton<AuthRepositoryImpl>(
      AuthRepositoryImpl(getIt<RemoteDataSource>()));
      
  // Register use cases
  getIt.registerSingleton<LoginUsecase>(
      LoginUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<SignupUsecase>(
      SignupUsecase(getIt<AuthRepositoryImpl>()));
      
  // Register blocs
  getIt.registerSingleton<AuthBloc>(
      AuthBloc(getIt<LoginUsecase>(), getIt<SignupUsecase>()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load(); // Load .env
  setupDependencies();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: MaterialApp(
        initialRoute: AppRouter.login,
        routes: AppRouter.getRoutes(),
      ),
    );
  }
}


