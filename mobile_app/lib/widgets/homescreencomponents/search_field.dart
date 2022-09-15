import 'package:flutter/material.dart';
import 'package:mobile_app/view/ui/screens/user/search_screen.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.screenSize,
    required this.searchController,
  }) : super(key: key);

  final Size screenSize;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width * 0.75,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade600.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: true,
        autofocus: false,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ));
        },
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
            ),
            hintText: "Search Item",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 7)),
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
