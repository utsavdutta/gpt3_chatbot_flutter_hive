import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_login_bloc/constants/cupertino_tab_items.dart';

class CupertinoHomeScaffold extends StatelessWidget {

  const CupertinoHomeScaffold(
      {Key? key,
      required this.currentTab,
      required this.onSelectTab,
      required this.widgetBuilder,
      required this.navigatorKey})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilder;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                height: MediaQuery.of(context).size.height * 0.1,
                onTap: (index) => onSelectTab(TabItem.values[index]),
                items: [_buildItem(TabItem.home), _buildItem(TabItem.account)],
              ),
              tabBuilder: (context, index) {
                final item = TabItem.values[index];
                return CupertinoTabView(
                  navigatorKey: navigatorKey[item],
                  builder: (context) => widgetBuilder[item]!(context),
                );
              }),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    // final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    final itemData = TabItemData.allTabs[tabItem];
    return BottomNavigationBarItem(
      
        label: itemData!.title,
        icon: Icon(
          itemData.icon,
        ));
  }
}
