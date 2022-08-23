import 'package:hive/hive.dart';

class Boxes {
  static Box<Map<dynamic, dynamic>> getNamesBox() =>
      Hive.box<Map<dynamic, dynamic>>("names");
  static Box<Map<dynamic, dynamic>> getLastNamesBox() =>
      Hive.box<Map<dynamic, dynamic>>("lastNames");
  static Box<Map<dynamic, dynamic>> getCommentsBox() =>
      Hive.box<Map<dynamic, dynamic>>("comments");
  static Box<Map<dynamic, dynamic>> getSendedCommentsBox() =>
      Hive.box<Map<dynamic, dynamic>>("sendedComments");
}
