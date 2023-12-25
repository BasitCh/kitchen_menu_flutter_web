// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/auth/i_auth_repository.dart';
import 'package:menumaster_manager/domain/login/i_login_repository.dart';
import 'package:widgets_book/widgets_book.dart';

class LoginRepository implements ILoginRepository {
  LoginRepository({
    required this.iAuthRepository,
  });

  final IAuthRepository iAuthRepository;

  @override
  Future<Either<FirebaseAuthException, User>> login(
      {required String email, required String password}) async {
    final response = await iAuthRepository.signInWithEmailAndPassword(
      emailAddress: email,
      password: password,
    );
    return response.fold(
      (FirebaseAuthException authException) => left(authException),
      (user) => right(user),
    );
  }

  @override
  Future<Either<FirebaseAuthException, Unit>> resetPasswordEmail(
      {required String email}) async {
    final response = await iAuthRepository.resetPassword(email: email);
    return response.fold(
      (l) => left(l),
      (r) => right(unit),
    );
  }
}
