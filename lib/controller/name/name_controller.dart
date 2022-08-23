import 'package:commenting/db/names_db_provider.dart';
import 'package:commenting/model/name.dart';
import 'package:get/get.dart';

class NameController extends GetxController {
  final NameDBProvider _nameDBProvider = NameDBProvider();

  @override
  onInit() {
    updateDBNames();
    super.onInit();
  }

  RxList<Name> dbNames = RxList([]);
  RxList<Name> male = RxList([]);
  RxList<Name> female = RxList([]);

  updateDBNames() {
    dbNames.value = _nameDBProvider.getNames();
    dbNames.value.forEach((element) {
      if (element.isMale) {
        male.add(element);
      } else {
        female.add(element);
      }
    });
    dbNames.refresh();
  }

  void removeName(Name name) {
    _nameDBProvider.removeName(name.uuid);
    updateDBNames();
  }

  void addName(Name name) {
    _nameDBProvider.addName(name);
    updateDBNames();
  }
}
