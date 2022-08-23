import 'package:commenting/controller/name/name_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:commenting/model/name.dart';
import 'package:commenting/widget/name/add_name_bottom_sheet.dart';
import 'package:commenting/widget/name/name_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NamesScreen extends StatelessWidget {
  const NamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final NameController _nameController = Get.find<NameController>();
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Obx(
        () {
          List<Name> names = _nameController.dbNames.value.reversed.toList();
          return Column(
            children: [
              names.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: names.length,
                          itemBuilder: (context, index) {
                            return NameRow(
                              name: names.elementAt(index),
                              onRemove: (name) {
                                _nameController.removeName(name);
                              },
                            );
                          }),
                    )
                  : Expanded(child: Lottie.asset('assets/anim/empty.json')),
              Container(
                height: 100,
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      isDismissible: true,
                      useRootNavigator: true,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return AddNameBottomSheet();
                      },
                    );
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
              SizedBox(
                height: size.height * .01,
              )
            ],
          );
        },
      ),
    );
  }
}
