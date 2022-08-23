import 'package:commenting/db/Boxes.dart';
import 'package:commenting/model/comment.dart';

class CommentDBProvider {
  static final CommentDBProvider _singleton = CommentDBProvider._internal();
  factory CommentDBProvider() => _singleton;
  CommentDBProvider._internal();

  List<Comment> getComments() {
    List<Comment> comments = [];
    for (Map<dynamic, dynamic> element in Boxes.getCommentsBox().values) {
      Map<String, dynamic> map = Map.fromEntries(element.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value)));
      comments.add(Comment.fromJson(map));
    }
    return comments;
  }

  bool containComment(String uuid) {
    for (Comment item in getComments()) {
      if (item.uuid == uuid) return true;
    }
    return false;
  }

  void addComment(Comment comment) async {
    if (!containComment(comment.uuid)) {
      Boxes.getCommentsBox().add(comment.toJson());
    }
  }

  void updateComment(Comment comment) async {
    if (containComment(comment.uuid)) {
      int index =
          getComments().indexWhere((element) => element.uuid == comment.uuid);
      Boxes.getCommentsBox().putAt(index, comment.toJson());
    }
  }

  void removeComment(String uuid) async {
    int index = getComments().indexWhere((element) => element.uuid == uuid);
    if (index != -1) Boxes.getCommentsBox().deleteAt(index);
  }

  void clear() {
    Boxes.getCommentsBox().clear();
  }
}
