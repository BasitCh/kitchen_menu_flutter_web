import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class PreparationSteps extends StatelessWidget {
  const PreparationSteps({
    required this.createPrepStepCubits, super.key,
    this.isReviewRecipe=false,
    this.isUser = false,
  });
  final CreatePrepStepCubits createPrepStepCubits;
  final bool isReviewRecipe;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return PreparationStepsWithTextField(
      createPrepStepCubits: createPrepStepCubits,
      isReviewRecipe: isReviewRecipe,
      isUser: isUser,
    );
  }
}

class PreparationStepsWithTextField extends StatefulWidget {
  const PreparationStepsWithTextField({
    required this.createPrepStepCubits,
    required this.isReviewRecipe,
    required this.isUser,
    super.key,
  });

  final CreatePrepStepCubits createPrepStepCubits;
  final bool isReviewRecipe;
  final bool isUser;

  @override
  State<PreparationStepsWithTextField> createState() =>
      _PreparationStepsWithTextFieldState();
}

class _PreparationStepsWithTextFieldState
    extends State<PreparationStepsWithTextField> {
  TextEditingController stepTextEditingController = TextEditingController();
  int orderNo = 1;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePrepStepCubits, List<PreparationStep>>(
      bloc: widget.createPrepStepCubits,
      builder: (context, prepStepsState) {
        return Column(
          children: [
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: prepStepsState.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                var prepStep = prepStepsState[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StandardText.subtitle2(
                              context,
                              '${AppLocalizations.of(context)!.create_recipe_step} ${index + 1}:',
                              fontWeight: AppFontWeight.bold,
                            ),
                            Visibility(
                              visible: !widget.isReviewRecipe,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<CreatePrepStepCubits>()
                                      .removeStep(prepStep);
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 17,
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        StandardText.subtitle3(
                          context,
                          prepStep.description ?? '',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if(!widget.isReviewRecipe && !widget.isUser) 10.verticalSpace,
            if(!widget.isReviewRecipe && !widget.isUser) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: context.width * .65,
                  child: AppStandardTextField.outlined(
                    maxLines: 4,
                    borderRadius: 4,
                    controller: stepTextEditingController,
                  ),
                ),
                5.horizontalGap,
                Expanded(
                  child: AppButton.darkRed(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(context.width * .13, 50),
                    maximumSize: Size(context.width * .13, 50),
                    child: Icon(Icons.add, size: 22.h,),
                    onPressed: () {
                      PreparationStep preparationStep = PreparationStep(
                        orderNo: orderNo,
                        description: stepTextEditingController.text,
                      );
                      context
                          .read<CreatePrepStepCubits>()
                          .addNewStep(preparationStep);
                      stepTextEditingController.clear();
                      orderNo++;
                    },
                  ),
                ),
              ],
            ),
            if(widget.isUser) 10.verticalSpace,
            if(widget.isUser) Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: context.width * .74,
                  child: AppStandardTextField.outlined(
                    maxLines: 4,
                    borderRadius: 4,
                    controller: stepTextEditingController,
                  ),
                ),
                5.horizontalGap,
                Expanded(
                  child: AppButton.darkRed(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(context.width * .13, 50),
                    maximumSize: Size(context.width * .13, 50),
                    child: Icon(Icons.add, size: 22.h,),
                    onPressed: () {
                      PreparationStep preparationStep = PreparationStep(
                        orderNo: orderNo,
                        description: stepTextEditingController.text,
                      );
                      context
                          .read<CreatePrepStepCubits>()
                          .addNewStep(preparationStep);
                      stepTextEditingController.clear();
                      orderNo++;
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
