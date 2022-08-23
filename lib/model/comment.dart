import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 1)
class Comment {
  Comment({
    required this.uuid,
    required this.title,
    required this.comment,
    this.author,
    this.email,
    this.rating,
    this.quality,
    this.price,
    this.advantages,
    this.disadvantage,
    this.recommended,
  });

  @HiveField(0)
  String uuid;
  @HiveField(1)
  String title;
  @HiveField(2)
  String comment;
  @HiveField(3)
  String? author;
  @HiveField(4)
  String? email;
  @HiveField(5)
  int? rating;
  @HiveField(6)
  int? quality;
  @HiveField(7)
  int? price;
  @HiveField(8)
  List<String>? advantages;
  @HiveField(9)
  List<String>? disadvantage;
  @HiveField(10)
  String? recommended;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['uuid'] = uuid;
    data['title'] = title;
    data['comment'] = comment;
    data['email'] = author;
    data['author'] = author;
    data['rating'] = rating;
    data['quality'] = quality;
    data['price'] = price;
    data['advantages'] = advantages;
    data['disadvantage'] = disadvantage;
    data['recommended'] = recommended;
    return data;
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    Comment temp = Comment(
      uuid: json['uuid'],
      title: json['title'],
      comment: json['comment'],
      author: json['author'],
      email: json['email'],
      rating: json['rating'],
      quality: json['quality'],
      price: json['price'],
      advantages: json['advantages'],
      disadvantage: json['disadvantage'],
      recommended: json['recommended'],
    );
    return temp;
  }
  factory Comment.fromJsonForLog(Map<String, dynamic> json) {
    Comment temp = Comment(
      uuid: json['uuid'],
      title: json['title'],
      comment: json['comment'],
      author: null,
      email: null,
      rating: null,
      quality: null,
      price: null,
      advantages: null,
      disadvantage: null,
      recommended: null,
    );
    return temp;
  }
}
