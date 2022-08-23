import 'package:flutter/material.dart';

class Style {
  static TextStyle getHeaderTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * .0125,
      color: Theme.of(context).hintColor,
      fontFamily: 'RegularPrimary',
    );
  }

  static TextStyle getLongTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * .01,
      color: Theme.of(context).hintColor,
      fontFamily: 'RegularPrimary',
    );
  }

  static TextStyle getDialogTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * .0125,
      color: Theme.of(context).hintColor,
      fontFamily: 'RegularPrimary',
    );
  }

  static TextStyle getPrimaryTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * .015,
      color: Theme.of(context).highlightColor,
      fontFamily: 'BoldPrimary',
    );
  }

  static TextStyle getAccentTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * .035,
      color: Theme.of(context).hoverColor,
      fontFamily: 'BoldPrimary',
    );
  }

  static TextStyle getSuccessTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * .013,
      color: const Color(0xFF76C790),
      fontFamily: 'BoldPrimary',
    );
  }

  static TextStyle getErrorTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * .013,
      color: Colors.red,
      fontFamily: 'BoldPrimary',
    );
  }

  static void showSnackbar(BuildContext context, String title) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            'خطا',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .0125,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontFamily: 'RegularPrimary',
            ),
          ),
          content: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .0125,
              color: Theme.of(context).hintColor,
              fontFamily: 'RegularPrimary',
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "تایید",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .0125,
                  color: Theme.of(context).buttonColor,
                  fontFamily: 'RegularPrimary',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
