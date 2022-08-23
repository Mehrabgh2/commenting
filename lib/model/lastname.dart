import 'package:hive/hive.dart';
part 'lastname.g.dart';

@HiveType(typeId: 4)
class LastName {
  LastName({required this.uuid, required this.lastname});
  @HiveField(0)
  final String uuid;
  @HiveField(1)
  final String lastname;

  factory LastName.fromJson(Map<String, dynamic> json) {
    return LastName(uuid: json['uuid'], lastname: json['lastname']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['uuid'] = uuid;
    data['lastname'] = lastname;
    return data;
  }
}
