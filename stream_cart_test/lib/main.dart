import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_cart_test/core/config/env.dart';
import 'package:stream_cart_test/data/datasources/remote_data_source.dart';
import 'package:stream_cart_test/data/repositories/auth_repository_impl.dart';
import 'package:stream_cart_test/domain/usecases/login_usecase.dart';
import 'package:stream_cart_test/domain/usecases/signup_usecase.dart';
import 'package:stream_cart_test/presentation/blocs/auth/auth_bloc.dart';
import 'package:stream_cart_test/presentation/pages/login_page.dart';
import 'package:stream_cart_test/presentation/pages/signup_page.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Register dependencies
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<RemoteDataSource>(RemoteDataSource(getIt<Dio>()));
  getIt.registerSingleton<AuthRepositoryImpl>(
      AuthRepositoryImpl(getIt<RemoteDataSource>()));
  getIt.registerSingleton<LoginUsecase>(
      LoginUsecase(getIt<AuthRepositoryImpl>()));
  getIt.registerSingleton<SignupUsecase>(
      SignupUsecase(getIt<AuthRepositoryImpl>()));
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
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignupPage(), 
        },
      ),
    );
  }
}


