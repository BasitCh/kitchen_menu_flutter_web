// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menumaster_manager/domain/meal_plans/company_allergies.dart';
import 'package:menumaster_manager/infrastructure/meal_plan/company_allergies_repository.dart';

part 'company_allergies_event.dart';
part 'company_allergies_state.dart';

class CompanyAllergiesBloc
    extends Bloc<CompanyAllergiesEvent, CompanyAllergiesState> {
  CompanyAllergiesBloc({
    required this.companyAllergiesRepository,
  }) : super(CompanyAllergiesInitial()) {
    on<GetCompanyAllergies>(_onGetCompanyAllergies);
  }

  final CompanyAllergiesRepository companyAllergiesRepository;

  Future<void> _onGetCompanyAllergies(
      GetCompanyAllergies event, Emitter<CompanyAllergiesState> emit) async {
    emit(CompanyAllergiesLoading());
    if (event.companyId != null) {
      final response = await companyAllergiesRepository.getCompanyAllergies(
        companyId: event.companyId!,
      );
      response.fold(
          (l) => emit(CompanyAllergiesError(
                message: l.message ?? 'Error getting allergies',
              )), (CompanyAllergies companyAllergies) {
        companyAllergies.data?.allergies != null ||
                companyAllergies.data!.allergies!.isNotEmpty
            ? emit(
                CompanyAllergiesLoaded(
                    allergies: companyAllergies.data!.allergies!),
              )
            : emit(
                CompanyAllergiesEmpty(),
              );
      });
    }
  }
}
