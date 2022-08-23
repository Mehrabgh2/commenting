import 'package:commenting/controller/name/name_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:commenting/model/name.dart';
import 'package:commenting/widget/core/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddNameBottomSheet extends StatefulWidget {
  @override
  State<AddNameBottomSheet> createState() => _AddNameBottomSheetState();
}

class _AddNameBottomSheetState extends State<AddNameBottomSheet> {
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
    final _devSize = MediaQuery.of(context).size;
    final NameController _nameController = Get.find<NameController>();
    return AnimatedPadding(
      duration: const Duration(milliseconds: 350),
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 250,
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
            Form(
              key: _formKey,
              child: textField,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _devSize.width * .02),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Text(
                      'جنسیت : ',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .015,
                        color: Theme.of(context).hintColor,
                        fontFamily: 'RegularPrimary',
                      ),
                    ),
                    SizedBox(
                      width: _devSize.width * .05,
                    ),
                    Row(
                      children: [
                        Text(
                          'مرد',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .015,
                            color: Theme.of(context).hintColor,
                            fontFamily: 'RegularPrimary',
                          ),
                        ),
                        SizedBox(
                          width: _devSize.width * .025,
                          child: FittedBox(
                            child: Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).buttonColor),
                              activeColor: Theme.of(context).focusColor,
                              value: isMale,
                              shape: const CircleBorder(),
                              onChanged: ((value) {
                                if (value!) {
                                  setState(() {
                                    isMale = true;
                                    focusNode.requestFocus();
                                  });
                                }
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: _devSize.width * .05,
                    ),
                    Row(
                      children: [
                        Text(
                          'زن',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .015,
                            color: Theme.of(context).hintColor,
                            fontFamily: 'RegularPrimary',
                          ),
                        ),
                        SizedBox(
                          width: _devSize.width * .025,
                          child: FittedBox(
                            child: Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).buttonColor),
                              activeColor: Theme.of(context).focusColor,
                              value: !isMale,
                              shape: const CircleBorder(),
                              onChanged: ((value) {
                                if (value!) {
                                  setState(() {
                                    isMale = false;
                                    focusNode.requestFocus();
                                  });
                                }
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  _formKey.currentState!.save();
                  focusNode.requestFocus();
                  if (_formKey.currentState!.validate() && name.isNotEmpty) {
                    _nameController.addName(
                      Name(
                          uuid: Uuid().v4().toString(),
                          name: name,
                          isMale: isMale),
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
                      'افزودن نام',
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
