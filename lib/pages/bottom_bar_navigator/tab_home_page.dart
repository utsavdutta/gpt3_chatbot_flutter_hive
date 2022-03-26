import 'package:flutter/material.dart';
import 'package:flutter_firebase_login_bloc/constants/cupertino_tab_items.dart';
import 'package:flutter_firebase_login_bloc/pages/bottom_bar_navigator/cupertino_home_scaffold.dart';
import 'package:flutter_firebase_login_bloc/pages/home_page.dart';
import 'package:flutter_firebase_login_bloc/pages/profile_page.dart';

class TabHomePage extends StatefulWidget {
  static const String routeName = '/tabHome';

  const TabHomePage({Key? key}) : super(key: key);

  @override
  _TabHomePageState createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  Map<TabItem, WidgetBuilder> get widgetBuilder {
    return {
      TabItem.home: (_) => HomePage(),
      TabItem.account: (_) => ProfilePage(),
    };
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKey = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>()
  };

  final TabItem _currentTab = TabItem.home;
  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {}
    setState(() => _currentTab);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          false,
      child: CupertinoHomeScaffold(
        navigatorKey: navigatorKey,
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilder: widgetBuilder,
      ),
    );
  }
}
