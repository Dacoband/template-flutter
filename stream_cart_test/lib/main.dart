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
import 'package:stream_cart_test/data/repositories/fake_user_repository.dart';
import 'package:stream_cart_test/data/repositories/fake_live_stream_repository.dart';
import 'package:stream_cart_test/data/repositories/fake_cart_repository.dart';
import 'package:stream_cart_test/domain/usecases/login_usecase.dart';
import 'package:stream_cart_test/domain/usecases/signup_usecase.dart';
import 'package:stream_cart_test/presentation/blocs/auth/auth_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/livestream/livestream_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/comment/comment_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/cart/cart_bloc.dart';
import 'package:stream_cart_test/presentation/blocs/cart/cart_event.dart';

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
      
  // Register fake repositories for local development
  getIt.registerSingleton<FakeUserRepository>(FakeUserRepository());
  getIt.registerSingleton<FakeLiveStreamRepository>(FakeLiveStreamRepository());
      
  // Register use cases
  getIt.registerSingleton<LoginUsecase>(
      LoginUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<SignupUsecase>(
      SignupUsecase(getIt<AuthRepositoryImpl>()));
      
  // Register blocs
  getIt.registerSingleton<AuthBloc>(
      AuthBloc(getIt<LoginUsecase>(), getIt<SignupUsecase>()));
    // Register LiveStream and Comment blocs
  getIt.registerSingleton<LiveStreamBloc>(
      LiveStreamBloc(getIt<FakeLiveStreamRepository>()));
  getIt.registerSingleton<CommentBloc>(
      CommentBloc(getIt<FakeLiveStreamRepository>()));
      
  // Register Cart Repository and Bloc
  getIt.registerSingleton<FakeCartRepository>(FakeCartRepository());
  getIt.registerSingleton<CartBloc>(
      CartBloc(getIt<FakeCartRepository>()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load(); // Load .env
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<CartBloc>()..add(LoadCartEvent())),
      ],
      child: MaterialApp(
        title: 'Stream Cart App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRouter.login,
        routes: AppRouter.getRoutes(),
      ),
    );
  }
}


