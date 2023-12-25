import 'package:widgets_book/widgets_book.dart';

class SelectedStateCubit extends Cubit<String?> {
  SelectedStateCubit() : super(null);

  void emitSelectedState(String? state) => emit(state);
}
