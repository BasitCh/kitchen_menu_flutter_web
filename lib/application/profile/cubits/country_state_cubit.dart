// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menumaster_manager/application/profile/cubits/countries_cubit.dart';

class CountryStatesCubit extends Cubit<List<String>> {
  CountryStatesCubit() : super([]);
  

  void getStates(String country) => emit(countryWithStates[country]!);
}