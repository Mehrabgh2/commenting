import 'package:commenting/core/style.dart';
import 'package:commenting/model/sended_comment.dart';
import 'package:commenting/widget/sendedcomment/sended_comment_dialog.dart';
import 'package:flutter/material.dart';

class SendedCommentRow extends StatelessWidget {
  const SendedCommentRow({required this.sendedComment, Key? key})
      : super(key: key);

  final SendedComment sendedComment;

  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;
    final _ratio = _devSize.height / _devSize.width;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return SendedCommentDialog(sendedComment: sendedComment);
          },
        );
      },
      child: Container(
        height: _devSize.height * .2,
        margin: EdgeInsets.symmetric(
            horizontal: _devSize.width * .02, vertical: _devSize.width * .005),
        padding: EdgeInsets.only(
            right: _devSize.width * .02, left: _devSize.width * .02),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _devSize.width * .4,
                    child: Row(
                      children: [
                        Text(
                          'عنوان کامنت : ',
                          textAlign: TextAlign.right,
                          style: Style.getHeaderTextStyle(context),
                        ),
                        Text(
                          sendedComment.comment.title.length < 50
                              ? sendedComment.comment.title
                              : sendedComment.comment.title.substring(0, 25) +
                                  ' ...',
                          textAlign: TextAlign.right,
                          style: Style.getLongTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: _devSize.width * .4,
                    child: Row(
                      children: [
                        Text(
                          'عنوان محصول : ',
                          textAlign: TextAlign.right,
                          style: Style.getHeaderTextStyle(context),
                        ),
                        Text(
                          sendedComment.product.title.length < 50
                              ? sendedComment.product.title
                              : sendedComment.product.title.substring(0, 25) +
                                  ' ...',
                          textAlign: TextAlign.right,
                          style: Style.getLongTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: _devSize.width * .4,
                    child: Text(
                      sendedComment.message,
                      textAlign: TextAlign.right,
                      style: sendedComment.isSuccess
                          ? Style.getSuccessTextStyle(context)
                          : Style.getErrorTextStyle(context),
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: _devSize.width * .025,
              ),
              Container(
                decoration: BoxDecoration(
                  color: sendedComment.isSuccess ? Colors.green : Colors.red,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(99),
                  ),
                ),
                width: 5,
                height: _devSize.height * .15,
              ),
              SizedBox(
                width: _devSize.width * .005,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
