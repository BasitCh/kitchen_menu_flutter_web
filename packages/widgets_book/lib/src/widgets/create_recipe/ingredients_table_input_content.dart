import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class IngredientsTableInputContent extends StatelessWidget {
  const IngredientsTableInputContent({
    required this.nameTextEditingController,
    required this.quantityTextEditingController,
    required this.priceTextEditingController,
    required this.onAddIngredient,
    required this.quantityWidget,
    this.isLoadingInfo,
    this.onChangedRecipeName,
    // this.quantityAppModalWidget,
    super.key,
  });

  final TextEditingController nameTextEditingController;
  final TextEditingController quantityTextEditingController;
  final TextEditingController priceTextEditingController;
  final Future<Ingredient> Function(Ingredient)? onAddIngredient;
  final bool? isLoadingInfo;
  final void Function(String)? onChangedRecipeName;
  final Widget quantityWidget;
  // final Widget? quantityAppModalWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex:  kIsWeb?10:5,
              fit: FlexFit.tight,

              child: kIsWeb? Material(
                elevation: 5,
                color: AppColors.greybg,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child: StandardTextField(
                borderRadius: 6,
                controller: nameTextEditingController,
                onChanged: onChangedRecipeName,
                hintText: 'Honey',
              ),):AppStandardTextField.outlined(
                borderRadius: 6,
                controller: nameTextEditingController,
                onChanged: onChangedRecipeName,
                hintText: 'Apple',
              )
              ,
            ),
            if (kIsWeb)5.horizontalSpace,
            if (kIsWeb) Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Material(
                elevation: 5,
                color: AppColors.greybg,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                child:StandardTextField(
                borderRadius: 6,
                controller: quantityTextEditingController,
              ),),

            ) else Container(),
            10.horizontalSpace,
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Material(
    elevation: 5,
    color: AppColors.greybg,
    borderRadius: const BorderRadius.all(Radius.circular(10)),

             child: quantityWidget,),
              // InkWell(
              //   onTap: () {
              //     if(quantityAppModalWidget!=null){
              //       showModalBottomSheet(
              //         context: context,
              //         isScrollControlled: true,
              //         enableDrag: true,
              //         builder: (modalContext) {
              //           return quantityAppModalWidget!;
              //         },
              //       );
              //     }
              //   },
              //   child: quantityWidget,
              // ),
            ),
            // 10.horizontalSpace,
            // Flexible(
            //   flex: kIsWeb?4:2,
            //   fit: FlexFit.tight,
            //   child: kIsWeb?
            //
            //   Material(
            //     elevation: 5,
            //     color: AppColors.greybg,
            //     borderRadius: const BorderRadius.all(Radius.circular(4)),
            //     child:StandardTextField(
            //     borderRadius: 6,
            //     controller: priceTextEditingController,
            //     prefixText: r'$',
            //     inputFormatter: [
            //       decimalInputFormatter,
            //     ],
            //     hintText: '6',
            //     // validator: (val) {
            //     //   if (val == null || val.isEmpty) {
            //     //     return '';
            //     //   } else {
            //     //     return null;
            //     //   }
            //     // },
            //   ),):AppStandardTextField.outlined(
            //     borderRadius: 6,
            //     controller: priceTextEditingController,
            //     prefixText: r'$',
            //     inputFormatter: [
            //       decimalInputFormatter,
            //     ],
            //     hintText: '6',
            //     // validator: (val) {
            //     //   if (val == null || val.isEmpty) {
            //     //     return '';
            //     //   } else {
            //     //     return null;
            //     //   }
            //     // },
            //   ),
            // ),
            10.horizontalSpace,
            Flexible(
              flex: kIsWeb?4:2,
              fit: FlexFit.tight,
              child: SizedBox(
                height: 45,
                child: (isLoadingInfo != null && isLoadingInfo!)
                    ? const AppButtonLoading()
                    : AppButton.darkRed(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          if (nameTextEditingController.text.isNotEmpty &&
                               quantityTextEditingController.text.isNotEmpty) {
                            final ingredient = Ingredient(
                              name: nameTextEditingController.text,
                              price: priceTextEditingController.text.isEmpty?0:
                                  double.parse(priceTextEditingController.text),
                              quantity: quantityTextEditingController.text,
                            );
                            if (onAddIngredient != null) {
                              var updatedIngredient =
                                  await onAddIngredient!(ingredient);
                              if(!kIsWeb) {
                                context
                                    .read<CreateIngredientsCubit>()
                                    .addNewIngredient(updatedIngredient);
                              }
                            } else {
                              if(!kIsWeb) {
                                context
                                    .read<CreateIngredientsCubit>()
                                    .addNewIngredient(ingredient);
                              }

                            }
                            nameTextEditingController.clear();
                            priceTextEditingController.clear();
                            quantityTextEditingController.clear();
                          }
                        },
                        child: const Icon(
                          Icons.add,
                          size: 20,
                        )),
              ),
            ),
          ],
        ),
        // 10.verticalSpace,
        // SizedBox(
        //   height: 45,
        //   width: 230,
        //   child: (isLoadingInfo != null && isLoadingInfo!)?
        //   const AppButtonLoading():AppButton.darkRed(
        //       padding: EdgeInsets.zero,
        //       onPressed: () async {
        //         if (nameTextEditingController.text.isNotEmpty &&
        //             priceTextEditingController.text.isNotEmpty &&
        //             quantityTextEditingController.text.isNotEmpty) {
        //           final ingredient = Ingredient(
        //             name: nameTextEditingController.text,
        //             price: double.parse(priceTextEditingController.text),
        //             quantity: quantityTextEditingController.text,
        //           );
        //           if (onAddIngredient != null) {
        //             var updatedIngredient =
        //             await onAddIngredient!(ingredient);
        //             context
        //                 .read<CreateIngredientsCubit>()
        //                 .addNewIngredient(updatedIngredient);
        //             print(updatedIngredient.toJson());
        //           } else {
        //             context
        //                 .read<CreateIngredientsCubit>()
        //                 .addNewIngredient(ingredient);
        //           }
        //           nameTextEditingController.clear();
        //           priceTextEditingController.clear();
        //           quantityTextEditingController.clear();
        //         }
        //       },
        //       child: const Icon(
        //         Icons.add,
        //         size: 20,
        //       )),
        // ),
      ],
    );
  }
}
