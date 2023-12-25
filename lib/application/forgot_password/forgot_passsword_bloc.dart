// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/infrastructure/login/login_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';
part 'forgot_passsword_event.dart';
part 'forgot_passsword_state.dart';

class ForgotPassswordBloc
    extends Bloc<ForgotPassswordEvent, ForgotPassswordState> {
  final LoginRepository loginRepository;

  ForgotPassswordBloc({
    required this.loginRepository,
  }) : super(ForgotPassswordInitial()) {
    on<SendPasswordResetEmail>(_onPasswordReset);
  }

  Future<void> _onPasswordReset(
      SendPasswordResetEmail event, Emitter<ForgotPassswordState> emit) async {
    emit(SendingEmail());
    final response = await loginRepository.resetPasswordEmail(
      email: event.email,
    );

    response.fold(
      (FirebaseAuthException exception) => emit(
        ErrorSendingEmail(
          error: exception.message ?? 'Error send email',
        ),
      ),
      (_) => emit(PasswordSent()),
    );
  }
}
