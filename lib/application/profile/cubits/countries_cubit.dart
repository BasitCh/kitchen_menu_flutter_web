// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';

final Map<String, List<String>> countryWithStates = {
  'New Zealand': [
    'Northland',
    'Auckland',
    'Waikato',
    'Bay Of Plenty',
    'Gisbourne',
    'Hawkes Bay',
    'Taranaki',
    'Manawatu-Whanganui',
    'Wellington',
    'Tasman',
    'Nelson',
    'Marlborough',
    'West Coast',
    'Canterbury',
    'Otago',
    'Southland'
  ],
  'Australia': [
    'Victoria',
    'Queensland',
    'South Australia',
    'Western Australia',
    'Tasmania',
    'Northern Territory',
    'Australian Capital Territory'
  ]
};

class CountriesCubit extends Cubit<List<String>> {
  CountriesCubit() : super([]);

  void getCountries() => emit(countryWithStates.keys.toList());
}
