import 'package:commenting/controller/name/lastname_controller.dart';
import 'package:commenting/model/lastname.dart';
import 'package:commenting/widget/core/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddLastNameBottomSheet extends StatefulWidget {
  @override
  State<AddLastNameBottomSheet> createState() => _AddLastNameBottomSheetState();
}

class _AddLastNameBottomSheetState extends State<AddLastNameBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isMale = true;
  String name = '';
  FocusNode focusNode = FocusNode();

  void setName(String newValue) {
    name = newValue;
  }

  late CustomTextFormField textField = CustomTextFormField(
    setter: setName,
    require: true,
    focusNode: focusNode,
  );

  @override
  Widget build(BuildContext context) {
    final LastNameController _lastnameController =
        Get.find<LastNameController>();
    return AnimatedPadding(
      duration: const Duration(milliseconds: 350),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Form(key: _formKey, child: textField),
            Container(
              height: 100,
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  _formKey.currentState!.save();
                  focusNode.requestFocus();
                  if (_formKey.currentState!.validate() && name.isNotEmpty) {
                    _lastnameController.addLastName(
                      LastName(
                        uuid: Uuid().v4().toString(),
                        lastname: name,
                      ),
                    );
                    setName('');
                    textField.clear();
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF4879F1),
                        Color(0xFF4F47E0),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'افزودن نام خانوادگی',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .011,
                        color: Colors.white,
                        fontFamily: 'RegularPrimary',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
