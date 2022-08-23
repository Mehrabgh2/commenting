import 'package:commenting/screen/lastnames_screen.dart';
import 'package:commenting/screen/names_screen.dart';
import 'package:flutter/material.dart';

class NamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(kToolbarHeight + _devSize.height * .02),
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: _devSize.height * .025),
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Container()),
                      TabBar(
                        labelPadding: const EdgeInsets.only(bottom: 10),
                        labelColor: Theme.of(context).hintColor,
                        indicatorColor: Theme.of(context).buttonColor,
                        unselectedLabelColor: Theme.of(context).hoverColor,
                        tabs: [
                          Text(
                            "نام",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .012,
                              color: Theme.of(context).hintColor,
                              fontFamily: 'RegularPrimary',
                            ),
                          ),
                          Text(
                            "نام خانوادگی",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .012,
                              color: Theme.of(context).hintColor,
                              fontFamily: 'RegularPrimary',
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              NamesScreen(),
              LastNamesScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
