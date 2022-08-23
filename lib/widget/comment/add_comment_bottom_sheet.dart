import 'package:commenting/controller/comment/comment_controller.dart';
import 'package:commenting/controller/progress_button_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:commenting/model/comment.dart';
import 'package:commenting/widget/core/custom_progress_button.dart';
import 'package:commenting/widget/core/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddCommentBottomSheet extends StatefulWidget {
  AddCommentBottomSheet({this.updateComment, Key? key}) : super(key: key);
  Comment? updateComment;

  @override
  State<AddCommentBottomSheet> createState() => _AddCommentBottomSheetState();
}

class _AddCommentBottomSheetState extends State<AddCommentBottomSheet> {
  late String title =
      widget.updateComment != null ? widget.updateComment!.title : '';
  late String comment =
      widget.updateComment != null ? widget.updateComment!.comment : '';
  late String? author =
      widget.updateComment != null ? widget.updateComment!.author : null;
  late String? email =
      widget.updateComment != null ? widget.updateComment!.email : null;
  late List<String>? advantages =
      widget.updateComment != null ? widget.updateComment!.advantages : null;
  late List<String>? disadvantages =
      widget.updateComment != null ? widget.updateComment!.disadvantage : null;
  late bool recommend = widget.updateComment != null
      ? widget.updateComment!.recommended == 'recommended'
      : false;
  late bool notRecommend = widget.updateComment != null
      ? widget.updateComment!.recommended == 'notrecommended'
      : false;
  late bool noIdea = widget.updateComment != null
      ? widget.updateComment!.recommended == 'no_idea'
      : false;
  late int? rating =
      widget.updateComment != null ? widget.updateComment!.rating : 5;
  late int? quality =
      widget.updateComment != null ? widget.updateComment!.quality : 3;
  late int? price =
      widget.updateComment != null ? widget.updateComment!.price : 3;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CommentController categoryController = Get.find<CommentController>();

  late CustomProgressButton customProgressButton = CustomProgressButton(
    idleText: widget.updateComment != null ? 'اعمال تغییرات' : 'اضافه کردن',
    loadingText: 'کمی صبر کنید',
    onPressed: widget.updateComment != null ? updateComment : addComment,
    progressButtonController: Get.put(ProgressButtonController()),
  );

  void addComment() async {
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    customProgressButton.setStatus(ButtonStatus.loading);
    categoryController.addComment(_createComment());
    Navigator.of(context).pop();
    customProgressButton.setStatus(ButtonStatus.idle);
  }

  void updateComment() async {
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    customProgressButton.setStatus(ButtonStatus.loading);
    categoryController.updateComment(_createUpdateComment());
    Navigator.of(context).pop();
    customProgressButton.setStatus(ButtonStatus.idle);
  }

  Comment _createUpdateComment() {
    return Comment(
      uuid: widget.updateComment!.uuid,
      title: title,
      comment: comment,
      author: author,
      email: email,
      rating: rating,
      price: price,
      quality: quality,
      recommended: _getRecommended(),
      advantages: advantages,
      disadvantage: disadvantages,
    );
  }

  Comment _createComment() {
    return Comment(
      uuid: Uuid().v4().toString(),
      title: title,
      comment: comment,
      author: author,
      email: email,
      rating: rating,
      price: price,
      quality: quality,
      recommended: _getRecommended(),
      advantages: advantages,
      disadvantage: disadvantages,
    );
  }

  String _getRecommended() {
    if (recommend) {
      return 'recommended';
    } else if (notRecommend) {
      return 'notrecommended';
    } else {
      return 'no_idea';
    }
  }

  void setTitle(String newValue) {
    title = newValue;
  }

  void setComment(String newValue) {
    comment = newValue;
  }

  void setEmail(String newValue) {
    email = newValue;
  }

  void setAdvantages(String newValue) {
    if (newValue.contains('&')) {
      advantages = newValue.split('&');
    } else {
      advantages = [newValue];
    }
  }

  void setDisadvantages(String newValue) {
    if (newValue.contains('&')) {
      disadvantages = newValue.split('&');
    } else {
      disadvantages = [newValue];
    }
  }

  void setRecommended(bool value, int index) {
    if (value) {
      switch (index) {
        case 0:
          recommend = true;
          notRecommend = false;
          noIdea = false;
          break;
        case 1:
          recommend = false;
          notRecommend = true;
          noIdea = false;
          break;
        case 2:
          recommend = false;
          notRecommend = false;
          noIdea = true;
          break;
      }
    } else {
      recommend = false;
      notRecommend = false;
      noIdea = false;
    }
    setState(() {});
  }

  void setRating(int value) {
    rating = value;
  }

  void setQuality(int value) {
    quality = value;
  }

  void setPrice(int value) {
    price = value;
  }

  String getSplited(List<String> value) {
    String data = '';
    if (value.length > 1) {
      for (int i = 0; i < value.length; i++) {
        if (i == value.length - 1) {
          data += value.elementAt(i);
        } else {
          data += '${value.elementAt(i)}&';
        }
      }
    } else if (value.length == 1) {
      data = value[0];
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.2,
      maxChildSize: 0.75,
      builder: (_, controller) {
        return AnimatedPadding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: const Duration(milliseconds: 350),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              setter: setTitle,
                              hint: 'عنوان',
                              title: title,
                              require: true,
                            ),
                            CustomTextFormField(
                              setter: setComment,
                              title: comment,
                              hint: 'کامنت',
                              require: true,
                            ),
                            CustomTextFormField(
                              setter: setEmail,
                              title: email ?? '',
                              hint: 'ایمیل',
                              require: false,
                            ),
                            CustomTextFormField(
                              setter: setAdvantages,
                              title: getSplited(advantages ?? []),
                              hint: 'نقاط مثبت',
                              require: false,
                            ),
                            CustomTextFormField(
                              setter: setDisadvantages,
                              title: getSplited(disadvantages ?? []),
                              hint: 'نقاط منفی',
                              require: false,
                            ),
                            Container(
                              width: _devSize.width,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: Theme.of(context).hoverColor,
                                ),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  children: [
                                    Text(
                                      'امتیاز',
                                      style: Style.getHeaderTextStyle(context),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: RatingBar.builder(
                                        updateOnDrag: true,
                                        initialRating: rating!.toDouble(),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: _devSize.width * .0275,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setRating(rating.floor());
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: _devSize.width,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: Theme.of(context).hoverColor,
                                ),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  children: [
                                    Text(
                                      'کیفیت',
                                      style: Style.getHeaderTextStyle(context),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: RatingBar.builder(
                                        updateOnDrag: true,
                                        initialRating: quality!.toDouble(),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: _devSize.width * .0275,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.add_chart_sharp,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setQuality(rating.floor());
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: _devSize.width,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: Theme.of(context).hoverColor,
                                ),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  children: [
                                    Text(
                                      'قیمت',
                                      style: Style.getHeaderTextStyle(context),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: RatingBar.builder(
                                        updateOnDrag: true,
                                        initialRating: price!.toDouble(),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemSize: _devSize.width * .0275,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.price_change_outlined,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setPrice(rating.floor());
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'پیشنهاد می کنم',
                                      style: Style.getHeaderTextStyle(context),
                                    ),
                                    CupertinoSwitch(
                                      activeColor:
                                          Theme.of(context).buttonColor,
                                      value: recommend,
                                      onChanged: (newValue) {
                                        setRecommended(newValue, 0);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'پیشنهاد نمی کنم',
                                      style: Style.getHeaderTextStyle(context),
                                    ),
                                    CupertinoSwitch(
                                      activeColor:
                                          Theme.of(context).buttonColor,
                                      value: notRecommend,
                                      onChanged: (newValue) {
                                        setRecommended(newValue, 1);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'نظری ندارم',
                                      style: Style.getHeaderTextStyle(context),
                                    ),
                                    CupertinoSwitch(
                                      activeColor:
                                          Theme.of(context).buttonColor,
                                      value: noIdea,
                                      onChanged: (newValue) {
                                        setRecommended(newValue, 2);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      customProgressButton
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
