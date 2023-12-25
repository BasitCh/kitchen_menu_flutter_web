part of 'company_allergies_bloc.dart';

abstract class CompanyAllergiesEvent extends Equatable {
  const CompanyAllergiesEvent();
}

class GetCompanyAllergies extends CompanyAllergiesEvent {
  GetCompanyAllergies({
    this.companyId,
  });

  final String? companyId;

  @override
  List<Object?> get props => [
        companyId,
      ];
}
