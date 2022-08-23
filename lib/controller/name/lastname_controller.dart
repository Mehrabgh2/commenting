import 'package:commenting/db/lastname_db_provider.dart';
import 'package:commenting/model/lastname.dart';
import 'package:commenting/model/name.dart';
import 'package:get/get.dart';

class LastNameController extends GetxController {
  final LastNameDBProvider _lastnameDBProvider = LastNameDBProvider();

  @override
  onInit() {
    updateDBLastNames();
    super.onInit();
  }

  RxList<LastName> dbLastNames = RxList([]);

  updateDBLastNames() {
    dbLastNames.value = _lastnameDBProvider.getLastNames();
    dbLastNames.refresh();
  }

  void removeLastName(LastName lastname) {
    _lastnameDBProvider.removeName(lastname.uuid);
    updateDBLastNames();
  }

  void addLastName(LastName lastname) {
    _lastnameDBProvider.addName(lastname);
    updateDBLastNames();
  }
}
