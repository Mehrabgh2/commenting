import 'package:commenting/db/send_comment_db_provider.dart';
import 'package:commenting/model/sended_comment.dart';
import 'package:get/get.dart';

class SendCommentController extends GetxController {
  final SendCommentDBProvider _commentDBProvider = SendCommentDBProvider();

  @override
  onInit() {
    updateDBComments();
    super.onInit();
  }

  RxList<SendedComment> dbComments = RxList([]);

  updateDBComments() {
    dbComments.value = _commentDBProvider.getComments();
    dbComments.refresh();
  }

  void removeComment(SendedComment comment) {
    _commentDBProvider.removeComment(comment.uuid);
    updateDBComments();
  }

  void addComment(SendedComment comment) {
    _commentDBProvider.addComment(comment);
    updateDBComments();
  }

  void updateComment(SendedComment comment) {
    _commentDBProvider.updateComment(comment);
    updateDBComments();
  }

  void clear() async {
    await _commentDBProvider.clear();
    updateDBComments();
  }
}
