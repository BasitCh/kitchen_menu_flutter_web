import 'package:widgets_book/widgets_book.dart';

class SelectedCountryCubit extends Cubit<String?> {
  SelectedCountryCubit() : super(null);

  void emitSelectedCountry(String country) => emit(country);
}
