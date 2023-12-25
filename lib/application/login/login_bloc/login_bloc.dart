// ignore_for_file: depend_on_referenced_packages
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/domain/sign_up/pref_user.dart';
import 'package:menumaster_manager/infrastructure/login/login_repository.dart';
import 'package:menumaster_manager/infrastructure/profile/profile_repository.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  final ProfileRepository profileRepository;

  LoginBloc({
    required this.loginRepository,
    required this.profileRepository,
  }) : super(LoginInitial()) {
    on<Login>(_onLogin);
    on<CheckUserVerification>(_onEmailVerification);
    on<CheckProfileUpdated>(_onCheckProfileUpdated);
    on<GetUserById>(_onFetchUserById);
  }

  Future<void> _onLogin(Login event, Emitter<LoginState> emit) async {
    emit(LoggingIn());
    final response = await loginRepository.login(
      email: event.email,
      password: event.password,
    );

    response.fold(
      (FirebaseAuthException exception) => emit(
        LoginError(
          message: exception.message ?? 'Error logging in',
        ),
      ),
      (user) => add(
        CheckUserVerification(
          user: user,
        ),
      ),
    );
  }

  Future<void> _onEmailVerification(
      CheckUserVerification event, Emitter<LoginState> emit) async {
    !event.user.emailVerified
        ? emit(
            LoginError(
              message: 'Please verify you email first then try to login again',
            ),
          )
        : add(CheckProfileUpdated());
  }

  Future<void> _onCheckProfileUpdated(
      CheckProfileUpdated event, Emitter<LoginState> emit) async {
    emit(LoggingIn());
    final response = await profileRepository.getUser();

    if (response.isRight()) {
      await SharedPreferenceService.delatePreferences();
      final user = response.getRight().toNullable();
      await SharedPreferenceService.saveUser(PrefUser(
        id: user?.id,
        firstName: user?.firstName,
        lastName: user?.lastName,
        fullName: user?.fullName,
        imageUrl: user?.imageUrl,
        phoneNumber: user?.phoneNumber,
        password: user?.password,
        companyId: user?.companyId,
        companyName: user?.companyName,
        chefRole: user?.chefRole,
        userRole: user?.userRole,
        subscriptionStatus: user?.subscriptionType,
        subscriptionType: user?.subscriptionStatus,
        address: user?.address,
        about: user?.about,
        isEmailVerified: user?.isEmailVerified,
        stripeCustomerId: user?.stripeCustomerId,
        stripePriceId: user?.stripePriceId,
        stripeProductId: user?.stripeProductId,
        subscriptionId: user?.subscriptionId,
      ));
    }

    response.fold(
        (error) => emit(
              LoginError(
                message: error.message ?? 'Error getting user profile',
              ),
            ), (user) async {
      if (user.userRole == null) {
        emit(LoginError(message: 'User not found'));
      } else if (user.userRole != null &&
          user.userRole!.toLowerCase() != UserType.Manager.name.toLowerCase()) {
        emit(LoginError(message: 'User does not have access'));
      } else if (user.companyId == null || user.companyId == '') {
        emit(CompanyProfileMissing());
      } else if ((user.firstName == null || user.lastName == null)) {
        emit(UserProfileMissing());
      } else {
        emit(LoggedIn());
      }
    });
  }

  Future<void> _onFetchUserById(
      GetUserById event, Emitter<LoginState> emit) async {
    emit(LoadingUser());
    final response = await profileRepository.getUserById(
      userId: event.userId,
    );

    response.fold(
      (ApiError exception) => emit(
        ErrorLoadingUser(
          error: exception.message ?? 'Error fetching user',
        ),
      ),
      (user) => emit(
        UserLoaded(user: user),
      ),
    );
  }
}
