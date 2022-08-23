import 'package:commenting/db/Boxes.dart';
import 'package:commenting/model/name.dart';

class NameDBProvider {
  static final NameDBProvider _singleton = NameDBProvider._internal();
  factory NameDBProvider() => _singleton;
  NameDBProvider._internal();

  List<Name> getNames() {
    List<Name> names = [];
    for (Map<dynamic, dynamic> element in Boxes.getNamesBox().values) {
      Map<String, dynamic> map = Map.fromEntries(element.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value)));
      names.add(Name.fromJson(map));
    }
    return names;
  }

  bool containName(Name name) {
    List<Name> names = getNames();
    bool cname = names.any((element) => element.name == name.name);
    bool cgender = names.any((element) => element.isMale == name.isMale);
    return cname && cgender;
  }

  void addName(Name name) async {
    if (!containName(name)) Boxes.getNamesBox().add(name.toJson());
  }

  void removeName(String uuid) async {
    int index = getNames().indexWhere((element) => element.uuid == uuid);
    if (index != -1) Boxes.getNamesBox().deleteAt(index);
  }
}
