import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatelessWidget {
  // final String searchIcon = "assets/icons/search_icon.svg";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: "Search Store",
          hintStyle: TextStyle(
            fontSize: 18,
            color: Color(0xFF7C7C7C),
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
