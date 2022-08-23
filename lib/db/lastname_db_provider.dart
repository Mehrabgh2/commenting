import 'package:commenting/db/Boxes.dart';
import 'package:commenting/model/lastname.dart';

class LastNameDBProvider {
  static final LastNameDBProvider _singleton = LastNameDBProvider._internal();
  factory LastNameDBProvider() => _singleton;
  LastNameDBProvider._internal();

  List<LastName> getLastNames() {
    List<LastName> lastnames = [];
    for (Map<dynamic, dynamic> element in Boxes.getLastNamesBox().values) {
      Map<String, dynamic> map = Map.fromEntries(element.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value)));
      lastnames.add(LastName.fromJson(map));
    }
    return lastnames;
  }

  bool containName(LastName name) {
    List<LastName> names = getLastNames();
    return names.any((element) => element.lastname == name.lastname);
  }

  void addName(LastName name) async {
    if (!containName(name)) Boxes.getLastNamesBox().add(name.toJson());
  }

  void removeName(String uuid) async {
    int index = getLastNames().indexWhere((element) => element.uuid == uuid);
    if (index != -1) Boxes.getLastNamesBox().deleteAt(index);
  }
}
