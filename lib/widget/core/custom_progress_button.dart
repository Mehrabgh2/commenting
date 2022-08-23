import 'package:commenting/controller/progress_button_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';

enum ButtonStatus {
  idle,
  loading,
}

class CustomProgressButton extends StatelessWidget {
  CustomProgressButton({
    Key? key,
    required this.idleText,
    required this.loadingText,
    required this.onPressed,
    required this.progressButtonController,
  }) : super(key: key);

  final String idleText;
  final String loadingText;
  final Function onPressed;
  final ProgressButtonController progressButtonController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => progressButtonController.buttonStatus.value == ButtonStatus.idle
          ? _createIdle(context)
          : _createLoading(context),
    );
  }

  void setStatus(ButtonStatus newStatus) {
    progressButtonController.updateButtonStatus(newStatus);
  }

  Widget _createIdle(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () => onPressed(),
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
              idleText,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * .0125,
                color: Colors.white,
                fontFamily: 'RegularPrimary',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createLoading(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: null,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulseSync,
                  colors: [
                    Color(0xFFED6C9D),
                    Color(0xFFE9953F),
                    Color(0xFF76C790),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Text(
                loadingText,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .0125,
                  color: Colors.white,
                  fontFamily: 'RegularPrimary',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
