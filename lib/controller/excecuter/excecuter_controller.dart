import 'dart:async';
import 'dart:math';

import 'package:commenting/api/api_service.dart';
import 'package:commenting/controller/comment/select_comment_controller.dart';
import 'package:commenting/controller/name/lastname_controller.dart';
import 'package:commenting/controller/name/name_controller.dart';
import 'package:commenting/controller/send_comment_controller.dart';
import 'package:commenting/enum/job_status.dart';
import 'package:commenting/enum/send_comment_status.dart';
import 'package:commenting/model/comment.dart';
import 'package:commenting/model/product.dart';
import 'package:commenting/model/sended_comment.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ExcecuteController extends GetxController {
  late Timer timer;
  int sendedIndex = 0;
  RxBool isMale = RxBool(true);
  RxBool isFemale = RxBool(true);
  int ccc = 0;
  int tempccc = 0;

  RxList<Product> fetchedProduct = RxList([]);
  RxList<SendedComment> sendedComments = RxList([]);
  RxList<JobStatus> jobsStatus = RxList([
    JobStatus.idleWithRun,
    JobStatus.idle,
    JobStatus.idle,
  ]);
  String error = '';
  RxInt sendedComment = RxInt(0);
  RxInt failedComment = RxInt(0);
  RxInt triedComment = RxInt(0);
  RxInt fetchedProductCount = RxInt(0);
  var sendCommentStatus = SendCommentStatus.idle.obs;
  RxInt delay = RxInt(2000);

  final SelectCommentController _selectCommentController =
      Get.find<SelectCommentController>();
  final SendCommentController _sendCommentController =
      Get.find<SendCommentController>();

  @override
  void onInit() {
    Timer.periodic(Duration(milliseconds: delay.value), (timer) {
      this.timer = timer;
      timer.cancel();
    });
    super.onInit();
  }

  void reset() {
    sendedIndex = 0;
    fetchedProduct.value.clear();
    sendedComments.value.clear();
    jobsStatus.value[0] = JobStatus.idleWithRun;
    jobsStatus.value[1] = JobStatus.idle;
    jobsStatus.value[2] = JobStatus.idle;
    jobsStatus.refresh();
    error = '';
    sendedComment.value = 0;
    failedComment.value = 0;
    triedComment.value = 0;
    fetchedProductCount.value = 0;
    ccc = 0;
    tempccc = 0;
    sendCommentStatus.value = SendCommentStatus.idle;
  }

  void createTimer() {
    Timer.periodic(Duration(milliseconds: delay.value), (timer) {
      this.timer = timer;
      sending();
    });
  }

  void addProduct(Product product) {
    fetchedProduct.add(product);
  }

  void bulkAddProduct(List<Product> products) {
    products.forEach((product) {
      fetchedProduct.add(product);
    });
    fetchedProductCount.value = fetchedProduct.value.length;
    fetchedProductCount.refresh();
    sendCommentStatus.refresh();
    tempccc++;
    if (ccc == tempccc) {
      createCommentObjects();
      ccc = 0;
      tempccc = 0;
    }
  }

  void getProducts(String link, int count, int page) async {
    jobsStatus.value[0] = JobStatus.doing;
    sendCommentStatus.value = SendCommentStatus.gettingProduct;
    jobsStatus.refresh();
    sendCommentStatus.refresh();
    if (link.contains('https://diginice.com/') ||
        link.contains('http://diginice.com/')) {
      (await ApiService.getProductCategoryLink(link)).fold(
        (l) {
          if (page == 0) {
            if (count > 100) {
              ccc = (count / 100).ceil();
              for (int i = 1; i < ccc + 1; i++) {
                if (i == ccc) {
                  getCategoryProducts(l, count % 100, i);
                } else {
                  getCategoryProducts(l, 100, i);
                }
              }
            } else {
              ccc = 1;
              getCategoryProducts(l, count, 1);
            }
          } else {
            ccc = 1;
            getCategoryProducts(l, count < 100 ? count : 100, page);
          }
        },
        (r) => reset(),
      );
    } else {
      if (page == 0) {
        if (count > 100) {
          ccc = (count / 100).ceil();
          for (int i = 1; i < ccc + 1; i++) {
            if (i == ccc) {
              getSearchProducts(link, count % 100, i);
            } else {
              getSearchProducts(link, 100, i);
            }
          }
        } else {
          ccc = 1;
          getSearchProducts(link, count, 1);
        }
      } else {
        ccc = 1;
        getSearchProducts(link, count < 100 ? count : 100, page);
      }
    }
  }

  void getCategoryProducts(int categoryCode, int count, int page) async {
    ApiService.getCategoryProducts(categoryCode, count, page).then((value) {
      value.fold(
        (l) => bulkAddProduct(l),
        (r) => reset(),
      );
    });
  }

  void getSearchProducts(String query, int count, int page) async {
    ApiService.getSearchProducts(query, count, page).then((value) {
      value.fold(
        (l) => bulkAddProduct(l),
        (r) => reset(),
      );
    });
  }

  void createCommentObjects() async {
    sendedComment.value = 0;
    failedComment.value = 0;
    jobsStatus.value[0] = JobStatus.success;
    jobsStatus.value[1] = JobStatus.doing;
    sendCommentStatus.value = SendCommentStatus.creatingObjects;
    jobsStatus.refresh();
    sendCommentStatus.refresh();
    List<SendedComment> _sendedComments = List.empty(growable: true);
    for (int i = 0; i < fetchedProduct.value.length; i++) {
      Product product = fetchedProduct.value.elementAt(i);
      int randCm = Random()
          .nextInt(_selectCommentController.selectedComments.value.length);
      Comment cm =
          _selectCommentController.selectedComments.value.elementAt(randCm);
      SendedComment temp = SendedComment(
        uuid: Uuid().v4(),
        comment: cm,
        product: product,
        time: DateTime.now().millisecondsSinceEpoch,
        message: 'ارسال نشده',
        isSuccess: false,
      );
      _sendedComments.add(temp);
    }
    await Future.delayed(const Duration(seconds: 3));
    sendedComments.value = _sendedComments;
    sendComment();
  }

  void sendComment() {
    jobsStatus.value[1] = JobStatus.success;
    jobsStatus.value[2] = JobStatus.doing;
    sendCommentStatus.value = SendCommentStatus.sendingComment;
    jobsStatus.refresh();
    sendCommentStatus.refresh();
    createTimer();
  }

  void stopSending() {
    sendedIndex = 0;
    jobsStatus.value[0] = JobStatus.idleWithRun;
    jobsStatus.value[1] = JobStatus.idle;
    jobsStatus.value[2] = JobStatus.idle;
    sendCommentStatus.value = SendCommentStatus.idle;
    sendedComment.value = 0;
    failedComment.value = 0;
    fetchedProductCount.value = 0;
    sendedComment.refresh();
    failedComment.refresh();
    fetchedProductCount.refresh();
    fetchedProduct.value.clear();
    sendedComments.value.clear();
    jobsStatus.refresh();
    sendCommentStatus.refresh();
    timer.cancel();
  }

  void sending() {
    if (triedComment.value < sendedComments.value.length) {
      SendedComment element = sendedComments.elementAt(sendedIndex++);
      element.comment.author = getRandomName();
      triedComment.value++;
      ApiService.sendComment(element).then(
        (value) => value.fold((l) {
          element.isSuccess = true;
          element.time = DateTime.now().millisecondsSinceEpoch;
          element.message = l;
          element.uuid = Uuid().v4();
          _sendCommentController.addComment(element);
          sendedComment.value++;
          sendedComment.refresh();
        }, (r) {
          element.isSuccess = false;
          element.time = DateTime.now().millisecondsSinceEpoch;
          element.message = r;
          element.uuid = Uuid().v4();
          _sendCommentController.addComment(element);
          failedComment.value++;
          failedComment.refresh();
        }),
      );
    } else {
      timer.cancel();
      jobsStatus.value[2] = JobStatus.success;
      sendCommentStatus.value = SendCommentStatus.sendingComplete;
      jobsStatus.refresh();
      sendCommentStatus.refresh();
    }
  }

  String? getRandomName() {
    final NameController _nameController = Get.find<NameController>();
    final LastNameController _lastnameController =
        Get.find<LastNameController>();
    if (_nameController.dbNames.value.isEmpty ||
        _lastnameController.dbLastNames.value.isEmpty) {
      return null;
    }
    var rand = Random();
    bool twoWords = rand.nextBool();
    bool firstname = rand.nextBool();
    List<String> names = List.empty(growable: true);
    if (isFemale.value) {
      names.addAll(_nameController.female.value.map((e) => e.name).toList());
    }
    if (isMale.value) {
      names.addAll(_nameController.male.value.map((e) => e.name).toList());
    }
    String firstName = names[rand.nextInt(names.length)];
    String lastName = _lastnameController
        .dbLastNames
        .value[rand.nextInt(_lastnameController.dbLastNames.value.length)]
        .lastname;
    if (twoWords) {
      return firstName + ' ' + lastName;
    } else if (firstname) {
      return firstName;
    } else {
      return lastName;
    }
  }
}
