import 'package:commenting/db/Boxes.dart';
import 'package:commenting/model/sended_comment.dart';

class SendCommentDBProvider {
  static final SendCommentDBProvider _singleton =
      SendCommentDBProvider._internal();
  factory SendCommentDBProvider() => _singleton;
  SendCommentDBProvider._internal();

  List<SendedComment> getComments() {
    List<SendedComment> comments = [];
    for (Map<dynamic, dynamic> element in Boxes.getSendedCommentsBox().values) {
      Map<String, dynamic> map = Map.fromEntries(element.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value)));
      comments.add(SendedComment.fromJson(map));
    }
    return comments;
  }

  bool containComment(String uuid) {
    for (SendedComment item in getComments()) {
      if (item.uuid == uuid) return true;
    }
    return false;
  }

  void addComment(SendedComment comment) async {
    if (!containComment(comment.uuid)) {
      Boxes.getSendedCommentsBox().add(comment.toJson());
    }
  }

  void updateComment(SendedComment comment) async {
    if (containComment(comment.uuid)) {
      int index =
          getComments().indexWhere((element) => element.uuid == comment.uuid);
      Boxes.getSendedCommentsBox().putAt(index, comment.toJson());
    }
  }

  void removeComment(String uuid) async {
    int index = getComments().indexWhere((element) => element.uuid == uuid);
    if (index != -1) Boxes.getSendedCommentsBox().deleteAt(index);
  }

  Future<void> clear() async {
    await Boxes.getSendedCommentsBox().clear();
  }
}
