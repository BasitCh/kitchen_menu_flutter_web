import 'package:flutter/material.dart';

class SetupProfileFormModel{
  SetupProfileFormModel({
    required this.fullNameTextEditingController,
    required this.phoneNoTextEditingController,
    required this.streetAddressTextEditingController,
    required this.aboutTextEditingController,
    required this.formKey,
});

  TextEditingController fullNameTextEditingController;
  TextEditingController phoneNoTextEditingController;
  TextEditingController streetAddressTextEditingController;
  TextEditingController aboutTextEditingController;
  GlobalKey<FormState> formKey;
}
