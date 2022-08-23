import 'package:commenting/enum/job_status.dart';
import 'package:get/get.dart';

class ExcecuteStatusController extends GetxController {
  RxList<JobStatus> statusesWidget = RxList([
    JobStatus.idle,
    JobStatus.doing,
    JobStatus.success,
    JobStatus.failed,
  ]);
}
