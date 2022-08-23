import 'package:commenting/core/style.dart';
import 'package:commenting/model/sended_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shamsi_date/shamsi_date.dart';

class SendedCommentDialog extends StatelessWidget {
  const SendedCommentDialog({required this.sendedComment, Key? key})
      : super(key: key);
  final SendedComment sendedComment;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      content: SizedBox(
        width: size.width * .8,
        height: size.height * .6,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'زمان : ${getTime()}',
                maxLines: 2,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: Style.getDialogTextStyle(context),
              ),
              spacer(size),
              Divider(color: Colors.blueGrey),
              spacer(size),
              Text(
                'عنوان : ${sendedComment.comment.title}',
                maxLines: 2,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: Style.getDialogTextStyle(context),
              ),
              spacer(size),
              Divider(color: Colors.blueGrey),
              spacer(size),
              Text(
                'کامنت : ${sendedComment.comment.comment}',
                maxLines: 4,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: Style.getDialogTextStyle(context),
              ),
              spacer(size),
              Divider(color: Colors.blueGrey),
              spacer(size),
              Text(
                'نویسنده : ${sendedComment.comment.author}',
                maxLines: 4,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: Style.getDialogTextStyle(context),
              ),
              spacer(size),
              Divider(color: Colors.blueGrey),
              spacer(size),
              Text(
                'محصول : ${sendedComment.product.title}',
                maxLines: 3,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: Style.getDialogTextStyle(context),
              ),
              spacer(size),
              const Divider(color: Colors.blueGrey),
              spacer(size),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: sendedComment.product.link),
                  );
                },
                child: Text(
                  'لینک محصول : ${sendedComment.product.link}',
                  maxLines: 8,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: Style.getDialogTextStyle(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getTime() {
    Jalali jalali = Jalali.fromDateTime(
      DateTime.fromMillisecondsSinceEpoch(
        sendedComment.time.toInt(),
      ),
    );
    String month = jalali.formatter.mN;
    String date = '${jalali.day} $month ${jalali.year}';
    String time = '${jalali.second} : ${jalali.minute} : ${jalali.hour}';
    return date + '  ساعت  ' + time;
  }

  Widget spacer(Size size) {
    return SizedBox(
      height: size.height * .01,
    );
  }
}
