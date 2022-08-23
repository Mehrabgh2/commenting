import 'package:commenting/controller/comment/select_comment_controller.dart';
import 'package:commenting/controller/excecuter/excecuter_controller.dart';
import 'package:commenting/controller/name/lastname_controller.dart';
import 'package:commenting/controller/name/name_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:commenting/enum/send_comment_status.dart';
import 'package:commenting/widget/core/custom_text_form_field.dart';
import 'package:commenting/widget/core/excecute_status_breadcrumb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExcecuteScreen extends StatelessWidget {
  final ExcecuteController _excecuteController = Get.find<ExcecuteController>();
  final SelectCommentController _selectCommentController =
      Get.find<SelectCommentController>();
  int count = 1;
  int page = 0;
  String link = '';

  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;

    void setTime(String newValue) {
      try {
        int time = int.parse(newValue);
        _excecuteController.delay.value = time;
      } catch (ex) {
        Style.showSnackbar(context, 'عدد صحیح نمیباشد');
      }
    }

    void setCount(String newValue) {
      try {
        int cc = int.parse(newValue);
        count = cc;
      } catch (ex) {}
    }

    void setPage(String newValue) {
      try {
        int cc = int.parse(newValue);
        page = cc;
      } catch (ex) {}
    }

    void setLink(String newValue) {
      link = newValue;
    }

    void onRun() {
      final NameController _nameController = Get.find<NameController>();
      final LastNameController _lastnameController =
          Get.find<LastNameController>();
      if (_selectCommentController.selectedComments.value.isEmpty) {
        Style.showSnackbar(context, 'هیچ کامنتی انتخاب نشده است');
      } else if (link.isEmpty) {
        Style.showSnackbar(context, 'لینک محصول را وارد کنید');
      } else if (count < 1) {
        Style.showSnackbar(context, 'تعداد محصولات نادرست است');
      } else if (!_excecuteController.isMale.value &&
          !_excecuteController.isFemale.value) {
        Style.showSnackbar(context, 'لطفا جنسیت را وارد کنید');
      } else if (_nameController.dbNames.value.isEmpty &&
          _lastnameController.dbLastNames.value.isEmpty) {
        Style.showSnackbar(context, 'هیچ نام یا نام خانوادگی ای وجود ندارد');
      } else if (page > 0 && count > 100) {
        Style.showSnackbar(context,
            'امکان دریافت محصولات صفحه با تعداد بیشتر از 100 وجود ندارد');
      } else {
        _excecuteController.getProducts(link, count, page);
      }
    }

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: _devSize.height * 1.1,
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).viewPadding.top +
                      _devSize.height * .05),
              CustomTextFormField(
                setter: setLink,
                title: link,
                hint: 'لینک یا کلمه سرچ',
                require: true,
                isLink: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _devSize.width * .5 - 40,
                    child: CustomTextFormField(
                      setter: setPage,
                      hint: 'صفحه',
                      title: page.toString(),
                      require: true,
                      isNumber: true,
                    ),
                  ),
                  SizedBox(
                    width: _devSize.width * .5 - 40,
                    child: CustomTextFormField(
                      setter: setCount,
                      hint: 'تعداد محصولات',
                      title: count.toString(),
                      require: true,
                      isNumber: true,
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                title: _excecuteController.delay.value.toString(),
                setter: setTime,
                require: true,
                isNumber: true,
                hint: 'تاخیر در اجرا (میلی ثانیه)',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _devSize.width * .06),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Text(
                        'جنسیت : ',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .012,
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
                              fontSize:
                                  MediaQuery.of(context).size.width * .012,
                              color: Theme.of(context).hintColor,
                              fontFamily: 'RegularPrimary',
                            ),
                          ),
                          Obx(
                            () => SizedBox(
                              width: _devSize.width * .025,
                              child: FittedBox(
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.all<Color>(
                                      Theme.of(context).buttonColor),
                                  activeColor: Theme.of(context).focusColor,
                                  value: _excecuteController.isMale.value,
                                  shape: const CircleBorder(),
                                  onChanged: ((value) {
                                    _excecuteController.isMale.value = value!;
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: _devSize.width * .15,
                      ),
                      Row(
                        children: [
                          Text(
                            'زن',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .012,
                              color: Theme.of(context).hintColor,
                              fontFamily: 'RegularPrimary',
                            ),
                          ),
                          Obx(
                            () => SizedBox(
                              width: _devSize.width * .025,
                              child: FittedBox(
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.all<Color>(
                                      Theme.of(context).buttonColor),
                                  activeColor: Theme.of(context).focusColor,
                                  value: _excecuteController.isFemale.value,
                                  shape: const CircleBorder(),
                                  onChanged: ((value) {
                                    _excecuteController.isFemale.value = value!;
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ExcecuteStatusBreadcrumb(
                onRun: onRun,
              ),
              Obx(
                () => Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: _devSize.height * .025,
                        ),
                        getStatusText(
                            _excecuteController.sendCommentStatus.value,
                            context),
                        SizedBox(
                          height: _devSize.height * .025,
                        ),
                        if (_excecuteController.sendCommentStatus.value ==
                            SendCommentStatus.sendingComplete)
                          Container(
                            height: 100,
                            padding: const EdgeInsets.all(20),
                            child: InkWell(
                              onTap: () {
                                _excecuteController.reset();
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
                                    'ریست',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              .013,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getStatusText(SendCommentStatus status, BuildContext context) {
    switch (status) {
      case SendCommentStatus.idle:
        return const Text('');
      case SendCommentStatus.gettingProduct:
        return Text(
          'تعداد ${_excecuteController.fetchedProductCount.value} محصول دریافت شده است',
          style: Style.getSuccessTextStyle(context),
        );
      case SendCommentStatus.creatingObjects:
        return Text(
          'تعداد ${_excecuteController.fetchedProductCount.value} محصول دریافت شد',
          style: Style.getSuccessTextStyle(context),
        );
      case SendCommentStatus.sendingComment:
        return Column(
          children: [
            Text(
              'تعداد ${_excecuteController.sendedComment.value} کامنت با موفقیت ارسال شد',
              style: Style.getSuccessTextStyle(context),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .025,
            ),
            Text(
              'تعداد ${_excecuteController.failedComment.value} کامنت با مشکل مواجه شد',
              style: Style.getErrorTextStyle(context),
            ),
          ],
        );
      case SendCommentStatus.sendingComplete:
        return Column(
          children: [
            Text(
              'تعداد ${_excecuteController.sendedComment.value} کامنت با موفقیت ارسال شد',
              style: Style.getSuccessTextStyle(context),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .025,
            ),
            Text(
              'تعداد ${_excecuteController.failedComment.value} کامنت با مشکل مواجه شد',
              style: Style.getErrorTextStyle(context),
            ),
          ],
        );
      case SendCommentStatus.facingError:
        return Text(
          _excecuteController.error,
          style: Style.getErrorTextStyle(context),
        );
    }
  }
}
