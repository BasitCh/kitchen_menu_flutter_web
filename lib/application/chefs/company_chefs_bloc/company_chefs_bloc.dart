// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/chefs/chefs_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'company_chefs_event.dart';
part 'company_chefs_state.dart';

class CompanyChefsBloc extends Bloc<CompanyChefsEvent, CompanyChefsState> {
  final ChefsRepository chefsRepository;

  CompanyChefsBloc({
    required this.chefsRepository,
  }) : super(CompanyChefsInitial()) {
    on<GetCompany>(_onLoadingCompany);
    on<GetActiveCompanyChefs>(_onGetActiveCompanyChefs);
  }

  Future<void> _onLoadingCompany(
    GetCompany event,
    Emitter<CompanyChefsState> emit,
  ) async {
    emit(LoadingChefs());
    final response = await chefsRepository.getCompany();
    response.fold(
        (l) => emit(ErrorLoadingCompanyChefs(error: l.message.toString())),
        (company) {
      add(GetActiveCompanyChefs(company: company));
    });
  }

  Future<void> _onGetActiveCompanyChefs(
    GetActiveCompanyChefs event,
    Emitter<CompanyChefsState> emit,
  ) async {
    emit(LoadingChefs());
    final chefs = await chefsRepository.getCompanyUsers();
    chefs.fold(
        (l) => emit(ErrorLoadingCompanyChefs(error: l.message.toString())),
        (chefs) {
      emit(
        CompanyChefsLoaded(
          company: event.company,
          chefs: chefs
              .where((element) =>
                  element.userRole == UserType.Chef.name &&
                  element.invitedBy == null)
              .toList(),
        ),
      );
    });
  }
}
