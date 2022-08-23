import 'package:commenting/controller/name/lastname_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:commenting/model/lastname.dart';
import 'package:commenting/widget/name/add_lastname_bottom_sheet.dart';
import 'package:commenting/widget/name/lastname_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LastNamesScreen extends StatelessWidget {
  const LastNamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final LastNameController _lastnameController =
        Get.find<LastNameController>();
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Obx(
        () {
          List<LastName> lastNames =
              _lastnameController.dbLastNames.value.reversed.toList();
          return Column(
            children: [
              lastNames.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: lastNames.length,
                          itemBuilder: (context, index) {
                            return LastNameRow(
                              lastName: lastNames.elementAt(index),
                              onRemove: (lastname) {
                                _lastnameController.removeLastName(lastname);
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
                        return AddLastNameBottomSheet();
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
