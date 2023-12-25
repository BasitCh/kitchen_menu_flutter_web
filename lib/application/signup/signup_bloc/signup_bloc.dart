// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/domain/auth/i_auth_repository.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/signup/signup_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'register_state.dart';
part 'signup_event.dart';

class SignupBloc extends Bloc<SignupEvent, RegisterState> {
  final SignupRepository signupRepository;
  SignupBloc({
    required this.signupRepository,
  }) : super(SignupInitial()) {
    on<SignUp>(_onSignup);
    on<SaveUser>(_onSaveUser);
    on<SendEmailVerification>(_onSendVerificationEmail);
  }

  Future<void> _onSignup(SignUp event, Emitter<RegisterState> emit) async {
    emit(SigningUp());
    final response = await signupRepository.createNewUser(
        email: event.email, password: event.password);
    response.fold(
      (l) => emit(
        ErrorSigningup(
          error: l.message ?? 'Error signing up',
        ),
      ),
      (r) => add(
        SaveUser(
          email: event.email,
        ),
      ),
    );
  }

  Future<void> _onSaveUser(SaveUser event, Emitter<RegisterState> emit) async {
    emit(SigningUp());
    final user = AppUser(
      id: getIt<IAuthRepository>().userId,
      email: event.email,
      userRole: UserType.Manager.name,
    );
    final uploadResponse = await signupRepository.saveUser(appUser: user);
    uploadResponse.fold((apiError) {
      emit(
        ErrorSigningup(
          error: apiError.message ?? 'Error storing user',
        ),
      );
    },
        (AppUser appUser) => add(
              SendEmailVerification(user: user),
            ));
  }

  Future<void> _onSendVerificationEmail(
      SendEmailVerification event, Emitter<RegisterState> emit) async {
    final response = await signupRepository.sendEmailVerificationLink();
    response.fold(
      (apiError) {
        emit(
          ErrorSigningup(
            error: apiError.message ?? 'Error',
          ),
        );
      },
      (r) {
        emit(
          Signedup(
            user: event.user,
          ),
        );
      },
    );
  }
}
