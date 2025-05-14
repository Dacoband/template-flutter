import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_cart_test/domain/usecases/login_usecase.dart';
import 'package:stream_cart_test/domain/usecases/signup_usecase.dart';
import 'package:stream_cart_test/presentation/blocs/auth/auth_event.dart';
import 'package:stream_cart_test/presentation/blocs/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;

  AuthBloc(this.loginUsecase, this.signupUsecase) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignUp);
  }
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await loginUsecase(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUp(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signupUsecase(event.email, event.password, event.name);
      // Since signupUsecase doesn't return a user, you might need to login after signup
      final user = await loginUsecase(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}