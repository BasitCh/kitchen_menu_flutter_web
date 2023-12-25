part of 'company_allergies_bloc.dart';

abstract class CompanyAllergiesState extends Equatable {
  const CompanyAllergiesState();
}

class CompanyAllergiesInitial extends CompanyAllergiesState {
  @override
  List<Object> get props => [];
}

class CompanyAllergiesLoading extends CompanyAllergiesState {
  @override
  List<Object> get props => [];
}

class CompanyAllergiesLoaded extends CompanyAllergiesState {
  CompanyAllergiesLoaded({
    required this.allergies,
  });

  final List<String> allergies;

  @override
  List<Object> get props => [];
}

class CompanyAllergiesEmpty extends CompanyAllergiesState {
  CompanyAllergiesEmpty();

  @override
  List<Object> get props => [];
}

class CompanyAllergiesError extends CompanyAllergiesState {
  CompanyAllergiesError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [];
}
