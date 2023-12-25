import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_book/src/widgets/create_recipe/preparation_step.dart';

class CreatePrepStepCubits extends Cubit<List<PreparationStep>>{
  CreatePrepStepCubits():super([]);

  void initialize(List<PreparationStep> ingredients) {
    emit(ingredients);
  }

  void addNewStep(PreparationStep preparationStep){
    state.add(preparationStep);
    emit(state.toList());
  }

  void removeStep(PreparationStep preparationStep){
    state.removeWhere((element) => element.description==preparationStep.description);
    emit(state.toList());
  }

  void reset(){
    emit([]);
  }
}