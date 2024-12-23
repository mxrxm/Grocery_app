// // import 'package:flutter/material.dart';
// // import 'package:grocery_app/common_widgets/app_text.dart';
// // import 'package:grocery_app/models/category_item.dart';
// // import 'package:grocery_app/widgets/category_item_card_widget.dart';
// // import 'package:grocery_app/widgets/search_bar_widget.dart';
// // import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// // import 'package:grocery_app/Screens/category_item_screen.dart';

// // List<Color> gridColors = [
// //   Color(0xff53B175),
// //   Color(0xffF8A44C),
// //   Color(0xffF7A593),
// //   Color(0xffD3B0E0),
// //   Color(0xffFDE598),
// //   Color(0xffB7DFF5),
// //   Color(0xff836AF6),
// //   Color(0xffD73B77),
// // ];

// // class ExploreScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: SafeArea(
// //       child: Column(
// //         children: [getHeader(), Expanded(child: getStaggeredGridView(context))],
// //       ),
// //     ));
// //   }
// // }

// // Widget getHeader() {
// //   return Column(
// //     children: [
// //       SizedBox(
// //         height: 20,
// //       ),
// //       Center(
// //         child: AppText(
// //           text: "Find Products",
// //           fontSize: 20,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //       Padding(
// //         padding: EdgeInsets.symmetric(horizontal: 10),
// //         child: SearchBarWidget(),
// //       ),
// //     ],
// //   );
// // }

// // Widget getStaggeredGridView(BuildContext context) {
// //   return SingleChildScrollView(
// //     padding: EdgeInsets.symmetric(
// //       vertical: 10,
// //     ),
// //     child: StaggeredGrid.count(
// //       crossAxisCount: 2,
// //       children: categoryItemsDemo.asMap().entries.map<Widget>((e) {
// //         int index = e.key;
// //         CategoryItem categoryItem = e.value;
// //         return GestureDetector(
// //           onTap: () {
// //             onCategoryItemClicked(context, categoryItem);
// //           },
// //           child: Container(
// //             padding: EdgeInsets.all(10),
// //             child: CategoryItemCardWidget(
// //               item: categoryItem,
// //               color: gridColors[index % gridColors.length],
// //             ),
// //           ),
// //         );
// //       }).toList(),
// //       mainAxisSpacing: 3.0,
// //       crossAxisSpacing: 4.0,
// //     ),
// //   );
// // }

// // void onCategoryItemClicked(BuildContext context, CategoryItem categoryItem) {
// //   Navigator.of(context).push(new MaterialPageRoute(
// //     builder: (BuildContext context) {
// //       return CategoryItemsScreen(cat: categoryItem.name,);
// //     },
// //   ));
// // }
// import 'package:flutter/material.dart';
// import 'package:grocery_app/common_widgets/app_text.dart';
// import 'package:grocery_app/models/category_item.dart';
// import 'package:grocery_app/widgets/category_item_card_widget.dart';
// import 'package:grocery_app/widgets/search_bar_widget.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:grocery_app/Screens/category_item_screen.dart';

// // Define the colors for grid items
// List<Color> gridColors = [
//   Color(0xff53B175),
//   Color(0xffF8A44C),
//   Color(0xffF7A593),
//   Color(0xffD3B0E0),
//   Color(0xffFDE598),
//   Color(0xffB7DFF5),
//   Color(0xff836AF6),
//   Color(0xffD73B77),
// ];

// class ExploreScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             getHeader(),
//             Expanded(child: getStaggeredGridView(context)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget getHeader() {
//     return Column(
//       children: [
//         SizedBox(
//           height: 20,
//         ),
//         Center(
//           child: AppText(
//             text: "Find Products",
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: SearchBarWidget(),
//         ),
//       ],
//     );
//   }

//   Widget getStaggeredGridView(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(
//         vertical: 10,
//       ),
//       child: StaggeredGrid.count(
//         crossAxisCount: 2,
//         children: categoryItemsDemo.asMap().entries.map<Widget>((e) {
//           int index = e.key;
//           CategoryItem categoryItem = e.value;
//           //cat_name = e.value;
//           return GestureDetector(
//             onTap: () {
//               onCategoryItemClicked(context, categoryItem);
//             },
//             child: Container(
//               padding: EdgeInsets.all(10),
//               child: CategoryItemCardWidget(
//                 item: categoryItem,
//                 color: gridColors[index % gridColors.length],
//               ),
//             ),
//           );
//         }).toList(),
//         mainAxisSpacing: 3.0,
//         crossAxisSpacing: 4.0,
//       ),
//     );
//   }

//   void onCategoryItemClicked(BuildContext context, CategoryItem categoryItem) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (BuildContext context) {
//           return CategoryItemsScreen(

//               );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/Screens/Items.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/models/category_item.dart';
import 'package:grocery_app/widgets/category_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart';

List<Color> gridColors = [
  Color(0xff53B175),
  Color(0xffF8A44C),
  Color(0xffF7A593),
  Color(0xffD3B0E0),
  Color(0xffFDE598),
  Color(0xffB7DFF5),
  Color(0xff836AF6),
  Color(0xffD73B77),
];

class ExploreScreen extends StatelessWidget {
  final String username; // Added username parameter

  ExploreScreen({Key? key, required this.username}) : super(key: key)
  {
    print("ExploreScreen initialized with username: $username");
  }

  final List<CategoryItem> categoryItemsDemo = [
    CategoryItem(
      name: "Fresh Fruits & Vegetables",
      imagePath: "images/fruit.png",
    ),
    CategoryItem(
      name: "Cooking Oil",
      imagePath: "images/oil.png",
    ),
    CategoryItem(
      name: "Meat & Fish",
      imagePath: "images/meat.png",
    ),
    CategoryItem(
      name: "Bakery & Snacks",
      imagePath: "images/bakery.png",
    ),
    CategoryItem(
      name: "Dairy & Eggs",
      imagePath: "images/dairy.png",
    ),
    CategoryItem(
      name: "Beverages",
      imagePath: "images/beverages.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getHeader(),
            Expanded(child: getStaggeredGridView(context)),
          ],
        ),
      ),
    );
  }

  Widget getHeader() {
    return Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              AppText(
                text: "Welcome, $username!",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 5),
              AppText(
                text: "Find Products",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SearchBarWidget(),
        ),
      ],
    );
  }

  Widget getStaggeredGridView(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        children: categoryItemsDemo.asMap().entries.map<Widget>((e) {
          int index = e.key;
          CategoryItem categoryItem = e.value;
          return GestureDetector(
            onTap: () {
              onCategoryItemClicked(context, categoryItem.name);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: CategoryItemCardWidget(
                item: categoryItem,
                color: gridColors[index % gridColors.length],
              ),
            ),
          );
        }).toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  void onCategoryItemClicked(BuildContext context, String categoryName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Items(category: categoryName, username: username);
        },
      ),
    );
  }
}
