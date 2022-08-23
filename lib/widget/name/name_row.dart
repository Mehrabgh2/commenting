import 'package:commenting/model/name.dart';
import 'package:flutter/material.dart';

class NameRow extends StatelessWidget {
  const NameRow({required this.name, required this.onRemove, Key? key})
      : super(key: key);

  final Name name;
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
            Row(
              children: [
                Text(
                  name.name,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * .012,
                    color: Theme.of(context).hintColor,
                    fontFamily: 'RegularPrimary',
                  ),
                ),
                SizedBox(
                  width: size.width * .05,
                ),
                Text(
                  name.isMale ? 'مرد' : 'زن',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * .012,
                    color: Theme.of(context).hoverColor,
                    fontFamily: 'RegularPrimary',
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                onRemove(name);
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
