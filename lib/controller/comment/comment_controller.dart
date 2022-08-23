import 'package:commenting/db/comment_db_provider.dart';
import 'package:commenting/model/comment.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final CommentDBProvider _commentDBProvider = CommentDBProvider();

  @override
  onInit() {
    updateDBComments();
    super.onInit();
  }

  RxList<Comment> dbComments = RxList([]);

  updateDBComments() {
    dbComments.value = _commentDBProvider.getComments();
    dbComments.refresh();
  }

  void removeComment(Comment comment) {
    _commentDBProvider.removeComment(comment.uuid);
    updateDBComments();
  }

  void addComment(Comment comment) {
    _commentDBProvider.addComment(comment);
    updateDBComments();
  }

  void updateComment(Comment comment) {
    _commentDBProvider.updateComment(comment);
    updateDBComments();
  }
}
