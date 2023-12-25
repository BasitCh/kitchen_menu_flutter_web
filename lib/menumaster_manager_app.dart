// ignore_for_file: always_specify_types

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menumaster_manager/application/chefs/chefs_bloc/chefs_bloc.dart';
import 'package:menumaster_manager/application/chefs/company_chefs_bloc/company_chefs_bloc.dart';
import 'package:menumaster_manager/application/chefs/remove_chef_bloc/remove_chef_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/add_child_bloc/add_child_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/allergies_bloc/allergies_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/apply_filters/apply_filters_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/filters_bloc/filters_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/get_children_bloc/get_children_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/recipe_detail/recipe_detail_bloc.dart';
import 'package:menumaster_manager/application/invite_chef/resend_invite/resend_invite_bloc.dart';
import 'package:menumaster_manager/application/login/login_bloc/login_bloc.dart';
import 'package:menumaster_manager/application/meal_plans/company_allergies_bloc/company_allergies_bloc.dart';
import 'package:menumaster_manager/application/meal_plans/cubits/create_shopping_list_cubit.dart';
import 'package:menumaster_manager/application/meal_plans/cubits/meal_plan_start_end_dates_cubit.dart';
import 'package:menumaster_manager/application/meal_plans/meal_plan_bloc/meal_plan_bloc.dart';
import 'package:menumaster_manager/application/meal_plans/shopping_list_bloc/shopping_list_bloc.dart';
import 'package:menumaster_manager/application/profile/manager_profile_bloc/manager_profile_bloc.dart';
import 'package:menumaster_manager/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:menumaster_manager/application/splash/splash_bloc/splash_bloc.dart';
import 'package:menumaster_manager/domain/services/storage/i_storage_repository.dart';
import 'package:menumaster_manager/infrastructure/chefs/chefs_repository.dart';
import 'package:menumaster_manager/infrastructure/children_with_allergies/children_repository.dart';
import 'package:menumaster_manager/infrastructure/children_with_allergies/filters_repository.dart';
import 'package:menumaster_manager/infrastructure/invite_chef/payment_repository.dart';
import 'package:menumaster_manager/infrastructure/login/login_repository.dart';
import 'package:menumaster_manager/infrastructure/meal_plan/all_recipes_repository.dart';
import 'package:menumaster_manager/infrastructure/meal_plan/company_allergies_repository.dart';
import 'package:menumaster_manager/infrastructure/meal_plan/meal_plan_repository.dart';
import 'package:menumaster_manager/infrastructure/profile/profile_repository.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:menumaster_manager/infrastructure/services/stripe_service.dart';
import 'package:menumaster_manager/infrastructure/signup/signup_repository.dart';
import 'package:menumaster_manager/presentation/intenet_connection/no_connection.dart';
import 'package:widgets_book/widgets_book.dart';

import 'domain/auth/i_auth_repository.dart';
import 'domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'infrastructure/di/injectable.dart';
import 'presentation/delegates/gorouter_delegate.dart';

class MenuMasterManagerApp extends StatefulWidget {
  const MenuMasterManagerApp({Key? key}) : super(key: key);

  @override
  State<MenuMasterManagerApp> createState() => _MenuMasterManagerAppState();
}

class _MenuMasterManagerAppState extends State<MenuMasterManagerApp> {
  // late ISignupRepository _signupRepository;
  late IAuthRepository _authRepository;
  late ICloudFirestoreRepository _firestoreRepository;
  late IStorageRepository _storageRepository;
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final _networkNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _networkNotifier.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _initNetwork();
    SharedPreferenceService.instance.init();

    super.initState();

    initRepositories();
  }

  _initNetwork() {
    _connectivity = Connectivity();
    initConnectivity();
    listenNetworkState();
  }

  listenNetworkState() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        _networkNotifier.value = true;
      } else {
        ConnectivityResult result = await _connectivity.checkConnectivity();
        if (result == ConnectivityResult.none) {
          _networkNotifier.value = true;
        } else {
          _networkNotifier.value = false;
        }
      }
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException {
      await _updateConnectionStatus(ConnectivityResult.none);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      _networkNotifier.value = true;
    } else {
      _networkNotifier.value = false;
    }
  }

  initRepositories() {
    _authRepository = getIt<IAuthRepository>();
    _firestoreRepository = getIt<ICloudFirestoreRepository>();
    _storageRepository = getIt<IStorageRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              LoginRepository(iAuthRepository: _authRepository),
        ),
        RepositoryProvider(
          create: (context) => SignupRepository(
              authRepository: _authRepository,
              firestoreRepository: _firestoreRepository),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(
            firestoreRepository: _firestoreRepository,
            storageRepository: _storageRepository,
            authRepository: _authRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => PaymentRepository(
            stripeService: StripeService(),
          ),
        ),
        RepositoryProvider(
          create: (context) =>
              FiltersRepository(cloudFirestoreRepository: _firestoreRepository),
        ),
        RepositoryProvider(
          create: (context) => ChildrenRepository(
              cloudFirestoreRepository: _firestoreRepository),
        ),
        RepositoryProvider(
          create: (context) =>
              ChefsRepository(cloudFirestoreRepository: _firestoreRepository),
        ),
        RepositoryProvider(
          create: (context) => MealPlanRepository(
            firestoreRepository: _firestoreRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => CompanyAllergiesRepository(
            firestoreRepository: _firestoreRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => AllRecipesRepository(
            cloudFirestoreRepository: _firestoreRepository,
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              loginRepository: RepositoryProvider.of<LoginRepository>(context),
              profileRepository:
                  RepositoryProvider.of<ProfileRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ChefsBloc(
              chefsRepository: RepositoryProvider.of<ChefsRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => CompanyChefsBloc(
              chefsRepository: RepositoryProvider.of<ChefsRepository>(context),
            ),
          ),
          BlocProvider<SplashBloc>(
            create: (context) => SplashBloc()..add(LoadSplash()),
          ),
          BlocProvider<AllergiesBloc>(
            create: (context) => AllergiesBloc(
              filtersRepository:
                  RepositoryProvider.of<FiltersRepository>(context),
            )..add(GetAllergies()),
          ),
          BlocProvider<FiltersBloc>(
            create: (context) => FiltersBloc(
                filtersRepository:
                    RepositoryProvider.of<FiltersRepository>(context))
              ..add(GetFilters()),
          ),
          BlocProvider<AttendanceBloc>(
            create: (context) => AttendanceBloc(
                filtersRepository:
                    RepositoryProvider.of<FiltersRepository>(context))
              ..add(GetWeekDays()),
          ),
          BlocProvider<ApplyFiltersBloc>(
            create: (context) => ApplyFiltersBloc(),
          ),
          BlocProvider(
            create: (context) => GetChildrenBloc(
              childrenRepository:
                  RepositoryProvider.of<ChildrenRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ResendInviteBloc(
              signupRepository:
                  RepositoryProvider.of<SignupRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => RemoveChefBloc(
              iCloudFirestoreRepository: _firestoreRepository,
              paymentRepository:
                  RepositoryProvider.of<PaymentRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => MealPlanStartEndDatesCubit(),
          ),
          BlocProvider(
            create: (context) => MealPlanBloc(
              mealPlanRepository:
                  RepositoryProvider.of<MealPlanRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => CreateShoppingListCubit(),
          ),
          BlocProvider(
            create: (context) => ShoppingListBloc(),
          ),
          BlocProvider<CompanyAllergiesBloc>(
            create: (context) => CompanyAllergiesBloc(
              companyAllergiesRepository:
                  RepositoryProvider.of<CompanyAllergiesRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => RecipeDetailBloc(
              allRecipesRepository:
                  RepositoryProvider.of<AllRecipesRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AddChildBloc(
              childrenRepository:
                  RepositoryProvider.of<ChildrenRepository>(context),
            ),
          ),
          BlocProvider<CreateIngredientsCubit>(
            create: (context) => CreateIngredientsCubit(),
          ),
          BlocProvider<CreatePrepStepCubits>(
            create: (context) => CreatePrepStepCubits(),
          ),
          BlocProvider(
            create: (context) => ManagerProfileBloc(
              profileRepository:
                  RepositoryProvider.of<ProfileRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(
              profileRepository:
                  RepositoryProvider.of<ProfileRepository>(context),
            ),
          ),
        ],
        child: _MenuMasterManagerApp(
          theme: AppTheme.themeData,
          networkNotifier: _networkNotifier,
        ),
      ),
    );
  }
}

class _MenuMasterManagerApp extends StatelessWidget {
  const _MenuMasterManagerApp({
    Key? key,
    required this.theme,
    required this.networkNotifier,
  }) : super(key: key);
  final ValueNotifier networkNotifier;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouterDelegate.routerConfig,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse},
      ),
      builder: (BuildContext context, Widget? child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            systemNavigationBarColor: AppColors.primary,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: ScreenUtilSetup(
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1,
                ),
                child: Stack(
                  children: [
                    child ?? Container(),
                    ValueListenableBuilder(
                      valueListenable: networkNotifier,
                      builder: (context, value, state) {
                        return value ? const NoConnection() : Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      theme: theme,
    );
  }
}
