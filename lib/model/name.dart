import 'package:hive/hive.dart';
part 'name.g.dart';

@HiveType(typeId: 3)
class Name {
  Name({
    required this.uuid,
    required this.name,
    required this.isMale,
  });
  @HiveField(0)
  final String uuid;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isMale;

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(uuid: json['uuid'], name: json['name'], isMale: json['isMale']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['uuid'] = uuid;
    data['name'] = name;
    data['isMale'] = isMale;
    return data;
  }
}
