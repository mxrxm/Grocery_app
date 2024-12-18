import 'package:flutter/material.dart';
import '../Database.dart';

class Items extends StatelessWidget {
    Items( this.category, {super.key});
final String category;
  ItemDb db = ItemDb();

  Future<List<Widget>> buildProductList() async {
    final List<Map<String, dynamic>> products = await db.getItems(category);
    // Map each product to a Widget (e.g., ProductCard)
    return products.map((product) {
      return ProductCard(
        image: product['image'],      // Path to the image
        title: product['title'],      // Product title
        quantity: product['quantity'], // Quantity description
        price:  product['price'].toString() +".LE",      // Price
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // Light background color
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            // Row of location
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_pin, size: 18, color: Colors.black),
                SizedBox(width: 5),
                Text(
                  "Cairo, Egypt",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Container of search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 250, 250),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Store",
                        hintStyle: TextStyle(color: Color(0xFF7C7C7C)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Container of offer banner
            Container(
              height: 120,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage("images/banner_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("images/banner_image.png", height: 100),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Fresh Vegetables",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Get Up To 40% OFF",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF82CA73),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Row of exclusive order
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Exclusive Order",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Function of tap here
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF82CA73),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Row of products
            FutureBuilder<List<Widget>>(
              future: buildProductList(),
              // Fetch the product list asynchronously
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator()); // Loading indicator
                } else if (snapshot.hasError) {
                  return Center(child: Text(
                      'Error: ${snapshot.error}')); // Error handling
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No products found')); // No products case
                } else {
                  return Wrap(
                    spacing: 10, // Horizontal space between children
                    runSpacing: 10, // Vertical space between rows
                    alignment: WrapAlignment.spaceBetween,
                    children: snapshot.data!, // Use the list of ProductCards
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

}

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String quantity;
  final String price;


  const ProductCard({
    required this.image,
    required this.title,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFC9C9C9)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(image, height: 80)),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            quantity,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF82CA73),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: () {
                    // Add function
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
