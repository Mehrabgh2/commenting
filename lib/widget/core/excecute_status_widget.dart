import 'package:commenting/core/style.dart';
import 'package:commenting/enum/job_status.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ExcecuteStatusWidget extends StatelessWidget {
  const ExcecuteStatusWidget({
    Key? key,
    required this.jobStatus,
    required this.title,
    required this.indexIcon,
    required this.onRun,
    required this.onStop,
  }) : super(key: key);
  final JobStatus jobStatus;
  final String title;
  final IconData indexIcon;
  final Function onRun;
  final Function? onStop;

  @override
  Widget build(BuildContext context) {
    switch (jobStatus) {
      case JobStatus.idle:
        return getIdleWidget(context);
      case JobStatus.idleWithRun:
        return getIdleWithRunWidget(context);
      case JobStatus.doing:
        return getDoingWidget(context);
      case JobStatus.success:
        return getSuccessWidget(context);
      case JobStatus.failed:
        return getFailedWidget(context);
    }
  }

  Widget getIdleWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .09,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    indexIcon,
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                SizedBox(
                  width: size.width * .025,
                ),
                Center(
                  child: Text(
                    title,
                    style: Style.getHeaderTextStyle(context),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getIdleWithRunWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .09,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    indexIcon,
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                SizedBox(
                  width: size.width * .025,
                ),
                Center(
                  child: Text(
                    title,
                    style: Style.getHeaderTextStyle(context),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              children: [
                ElevatedButton(
                  child: const Icon(Icons.play_arrow_rounded),
                  onPressed: () {
                    onRun();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).buttonColor,
                    fixedSize: Size(size.width * .105, size.width * .105),
                    shape: const CircleBorder(),
                  ),
                ),
                SizedBox(
                  width: size.width * .035,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getDoingWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .09,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Row(
              children: [
                const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.offline_bolt_rounded,
                    color: Color(0xFFE9953F),
                  ),
                ),
                SizedBox(
                  width: size.width * .025,
                ),
                Center(
                  child: Text(
                    title,
                    style: Style.getHeaderTextStyle(context),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              children: [
                if (onStop != null)
                  ElevatedButton(
                    child: const Icon(Icons.stop_rounded),
                    onPressed: () {
                      onStop!();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).buttonColor,
                      fixedSize: Size(size.width * .105, size.width * .105),
                      shape: const CircleBorder(),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulseSync,
                    colors: [
                      Color(0xFFED6C9D),
                      Color(0xFFE9953F),
                      Color(0xFF76C790),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width * .065,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getSuccessWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .09,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.done_rounded,
                    color: Color(0xFF76C790),
                  ),
                ),
                SizedBox(
                  width: size.width * .035,
                ),
                Center(
                  child: Text(
                    title,
                    style: Style.getHeaderTextStyle(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getFailedWidget(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .09,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: size.width * .025,
                ),
                Center(
                  child: Text(
                    title,
                    style: Style.getHeaderTextStyle(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
