import 'package:commenting/model/comment.dart';
import 'package:commenting/model/product.dart';
import 'package:hive/hive.dart';

part 'sended_comment.g.dart';

@HiveType(typeId: 2)
class SendedComment {
  SendedComment({
    required this.uuid,
    required this.comment,
    required this.product,
    required this.time,
    required this.isSuccess,
    required this.message,
  });

  @HiveField(0)
  String uuid;
  @HiveField(1)
  Comment comment;
  @HiveField(2)
  Product product;
  @HiveField(3)
  num time;
  @HiveField(4)
  bool isSuccess;
  @HiveField(5)
  String message;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['uuid'] = uuid;
    data['comment'] = comment.toJson();
    data['product'] = product.toJson();
    data['time'] = time;
    data['message'] = message;
    data['isSuccess'] = isSuccess;
    return data;
  }

  factory SendedComment.fromJson(Map<String, dynamic> json) {
    Map<dynamic, dynamic> ptemp = json['product'];
    Map<dynamic, dynamic> ctemp = json['comment'];
    Map<String, dynamic> pp = {};
    Map<String, dynamic> cc = {};
    ptemp.entries.forEach((element) {
      pp.addAll({element.key.toString(): element.value});
    });
    ctemp.entries.forEach((element) {
      cc.addAll({element.key.toString(): element.value});
    });
    return SendedComment(
      uuid: json['uuid'],
      product: Product.fromJson(pp),
      comment: Comment.fromJson(cc),
      time: json['time'],
      message: json['message'],
      isSuccess: json['isSuccess'],
    );
  }

  Map<String, dynamic> toFormData() {
    Map<String, dynamic> form = {
      'comment-form-title': comment.title,
      'comment': comment.comment,
      'submit': 'ثبت',
      'comment_post_ID': product.id,
    };
    if (comment.rating != null) {
      form.addAll({'rating': comment.rating});
    }
    if (comment.recommended != null) {
      form.addAll({'recommended': comment.recommended});
    }
    if (comment.quality != null) {
      form.addAll({'optionRatings[Quality]': comment.quality});
    }
    if (comment.price != null) {
      form.addAll({'optionRatings[Price]': comment.price});
    }
    if (comment.author != null) {
      form.addAll({'author': comment.author});
    }
    if (comment.email != null) {
      form.addAll({'email': comment.email});
    }
    if (comment.advantages != null) {
      form.addAll({'advantages[]': comment.advantages});
    }
    if (comment.advantages != null) {
      form.addAll({'disadvantages[]': comment.disadvantage});
    }
    return form;
  }
}
