// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/chefs/chefs_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'chefs_event.dart';
part 'chefs_state.dart';

class ChefsBloc extends Bloc<ChefsEvent, ChefsState> {
  final ChefsRepository chefsRepository;

  ChefsBloc({required this.chefsRepository}) : super(ChefsInitial()) {
    on<GetCompany>(_onLoadingCompany);
    on<GetCompanyChefs>(_onLoadingCompanyChefs);
  }

  Future<void> _onLoadingCompany(
    GetCompany event,
    Emitter<ChefsState> emit,
  ) async {
    emit(LoadingChefs());
    final response = await chefsRepository.getCompany();
    response.fold(
        (l) => emit(ErrorLoadingCompanyChefs(error: l.message.toString())),
        (company) {
      add(GetCompanyChefs(company: company));
    });
  }

  Future<void> _onLoadingCompanyChefs(
    GetCompanyChefs event,
    Emitter<ChefsState> emit,
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
              .where((element) => element.userRole == UserType.Chef.name)
              .toList(),
        ),
      );
    });
  }
}
