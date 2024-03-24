/* this Widget is create to have the Tabbar
in homepage */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';
import 'package:tripmakerflutterapp/provider/darkMode_provider.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/populatList_folder/commonwidget.dart';
import 'package:tripmakerflutterapp/view/widget/common_widget/tabbar_folder/tabBarList_widget.dart';

class TabViewWidget extends StatefulWidget {
  const TabViewWidget({super.key});

  @override
  State<TabViewWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<TabViewProvider>(context, listen: false);
    // auth.initTabController(this);
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: SizedBox(
            width: width / 1,
            height: height / 19,
            child: TabBar(
              labelColor: Provider.of<DarkModeProvider>(context).value
                  ? Colors.white
                  : Colors.black,
              labelStyle: TextStyle(
                color: Provider.of<DarkModeProvider>(context).value
                    ? Colors.white
                    : Colors.black,
              ),
              controller: _tabController,
              tabs: const [
                FittedBox(
                  child: Tab(
                    text: 'Most Popular',
                  ),
                ),
                FittedBox(
                  child: Tab(
                    text: 'Recommended',
                  ),
                ),
                FittedBox(
                  child: Tab(
                    text: 'Trending',
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: width / 1,
            height: height / 3.5,
            child: TabBarView(
              controller: _tabController,
              children: [
                SizedBox(
                  child: TabBarListWidget(
                    placeListNotifierCommon:
                        PlacesDB.instance.placeListNotifier,
                  ),
                ),
                SizedBox(
                  child: TabBarListWidget(
                    placeListNotifierCommon:
                        PlacesDB.instance.momumentsCategoryListNotifier,
                  ),
                ),
                SizedBox(
                  child: TabBarListWidget(
                    placeListNotifierCommon:
                        PlacesDB.instance.beachCategoryNotifier,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
