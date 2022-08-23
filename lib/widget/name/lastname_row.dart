import 'package:commenting/model/lastname.dart';
import 'package:flutter/material.dart';

class LastNameRow extends StatelessWidget {
  const LastNameRow({required this.lastName, required this.onRemove, Key? key})
      : super(key: key);

  final LastName lastName;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .06,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lastName.lastname,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * .012,
                color: Theme.of(context).hintColor,
                fontFamily: 'RegularPrimary',
              ),
            ),
            GestureDetector(
              onTap: () {
                onRemove(lastName);
              },
              child: Icon(
                Icons.delete_outline_rounded,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
