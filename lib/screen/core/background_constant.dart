import 'package:flutter/material.dart';

class BackgroundConstant extends StatelessWidget {
  const BackgroundConstant({Key? key, this.buttonFunction, this.buttonIcon})
      : super(key: key);
  final Function? buttonFunction;
  final IconData? buttonIcon;
  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;
    return SizedBox(
      height: _devSize.height * .025,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (buttonFunction != null && buttonIcon != null)
            Container(
              margin: EdgeInsets.only(top: _devSize.height * .05),
              height: _devSize.height * .08,
              width: _devSize.height * .08,
              child: IconButton(
                  onPressed: () {
                    buttonFunction!(context);
                  },
                  icon: Icon(buttonIcon),
                  color: Theme.of(context).hoverColor),
            ),
        ],
      ),
    );
  }
}
