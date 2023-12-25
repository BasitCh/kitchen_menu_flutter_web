import 'package:widgets_book/widgets_book.dart';

class CreateShoppingListCubit extends Cubit<bool> {
  CreateShoppingListCubit() : super(false);

  void initialize(bool value) {
    emit(value);
  }

  void reset() {
    emit(false);
  }
}
