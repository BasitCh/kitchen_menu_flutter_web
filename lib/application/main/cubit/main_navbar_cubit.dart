// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavBarCubit extends Cubit<int> {
  MainNavBarCubit() : super(0);
  void changeDrawerNavBar(int index) => emit(index);
}
