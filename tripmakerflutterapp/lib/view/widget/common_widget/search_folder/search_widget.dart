/*this widet is used to build the search bar
maimly in the home and search page */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/provider/searchwidget_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';

class SearchWidget extends StatelessWidget {
  final bool isNavigation;
  final void Function(String)? onSearch;

  const SearchWidget({
    required this.isNavigation,
    this.onSearch,
    Key? key,
  }) : super(key: key);

  // TextEditingController searchController = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<SearchProvider>(context);
    auth.listenText();
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 0,
        ),
        child: TextField(
          controller: auth.searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            labelText: 'Search for the Destinations',
            prefixIcon: IconButton(
              onPressed: () {
                if (isNavigation == true) {
                  ScreenSelection.selectedIndexNotifier.value = 1;
                }
              },
              icon: const Icon(Icons.search),
            ),
            suffixIcon: const Icon(
              Icons.file_copy,
            ),
          ),
        ),
      ),
    );
  }
}
