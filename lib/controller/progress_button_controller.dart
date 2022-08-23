import 'package:commenting/widget/core/custom_progress_button.dart';
import 'package:get/get.dart';

class ProgressButtonController extends GetxController {
  var buttonStatus = ButtonStatus.idle.obs;
  void updateButtonStatus(ButtonStatus newStatus) {
    buttonStatus(newStatus);
  }
}
