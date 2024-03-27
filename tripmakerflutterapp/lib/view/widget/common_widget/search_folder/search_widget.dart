/*this widet is used to build the search bar
maimly in the home and search page */
import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_folder/home_Screen.dart';

// class SearchWidget extends StatelessWidget {
//   final bool isNavigation;
//   final void Function(String)? onSearch;

//   const SearchWidget({
//     required this.isNavigation,
//     this.onSearch,
//     Key? key,
//   }) : super(key: key);

//   // TextEditingController searchController = TextEditingController();

//   // @override
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<SearchProvider>(context);
//     auth.listenText();

//     return SizedBox(
//       child: Padding(
//         padding: const EdgeInsets.only(
//           left: 15,
//           right: 15,
//           top: 10,
//           bottom: 0,
//         ),
//         child: TextField(
//           controller: auth.searchController,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(50),
//             ),
//             labelText: 'Search for the Destinations',
//             prefixIcon: IconButton(
//               onPressed: () {
//                 if (isNavigation == true) {
//                   ScreenSelection.selectedIndexNotifier.value = 1;
//                 }
//               },
//               icon: const Icon(Icons.search),
//             ),
//             suffixIcon: const Icon(
//               Icons.file_copy,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class SearchWidget extends StatefulWidget {
  final bool isNavigation;
  final void Function(String)? onSearch;

  const SearchWidget({
    required this.isNavigation,
    this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
  void updateSearchText(String searchText) {
    // Call the provided callback function to send the value
    if (onSearch != null) {
      onSearch!(searchText);
    }
  }
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      // Call the callback function with the current text value
      widget.updateSearchText(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 10,
          bottom: 0,
        ),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            labelText: 'Search for the Destinations',
            prefixIcon: IconButton(
              onPressed: () {
                if (widget.isNavigation == true) {
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
