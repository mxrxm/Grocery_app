import 'package:flutter/material.dart';
import '../Database.dart';
import 'CheckoutScreen.dart';

class CartScreen extends StatefulWidget {
  final String username;

  CartScreen({required this.username}){
    print("ExploreScreen initialized with username: $username");
  }

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ItemDb db = ItemDb();
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    final items = await db.getCartItems(widget.username); // Fetch items for the username
    setState(() {
      cartItems = items.map((item) {
        return {
          'id': item['cart_id'] ?? -1, // Ensure 'cart_id' is used correctly
          'item_img': item['item_img'] ?? '', // Default to empty string if null
          'item_name': item['item_name'] ?? 'Unnamed Item', // Default name
          'item_quantity': item['item_quantity'] ?? 0, // Default quantity to 0
          'item_price': item['item_price']?.toDouble() ?? 0.0, // Default price to 0.0
        };
      }).toList();
    });
  }

  Future<void> removeItem(int itemId) async {
    try {
      await db.removeItemFromCart(itemId, widget.username); // Pass username for validation
      setState(() {
        cartItems.removeWhere((item) => item['id'] == itemId); // Update UI directly
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to remove item: $e')),
      );
    }
  }

  Future<double> getTotalPrice() async {
    return await db.getTotalPrice(widget.username); // Fetch total price for the username
  }

  Future<void> navigateToCheckout() async {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart is empty. Add items to checkout.')),
      );
      return;
    }

    final totalPrice = await getTotalPrice(); // Get total price dynamically

    // Navigate to CheckoutScreen and refresh cart on return
    await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => CheckoutScreen(
      totalPrice: totalPrice,
      cartItems: cartItems,
      username: widget.username, // Pass the username to the CheckoutScreen
    ),
  ),
);


    // Refresh cart items after returning from checkout
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF82CA73),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: cartItems.isEmpty
            ? const Center(child: Text('Your cart is empty.'))
            : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return CartItemWidget(
                    itemId: item['id'],
                    image: item['item_img'],
                    title: item['item_name'],
                    quantity: item['item_quantity'],
                    price: item['item_price'],
                    onRemoveFromCart: () => removeItem(item['id']),
                  );
                },
              ),
      ),
      bottomSheet: FutureBuilder<double>(
        future: getTotalPrice(),
        builder: (context, snapshot) {
          final totalPrice = snapshot.data ?? 0.0;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: const Color(0xFF82CA73),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${totalPrice.toStringAsFixed(2)} LE',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: navigateToCheckout,
                  child: const Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF82CA73),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class CartItemWidget extends StatelessWidget {
  final int itemId;
  final String image;
  final String title;
  final int quantity;
  final double price;
  final VoidCallback onRemoveFromCart;

  const CartItemWidget({
    required this.itemId,
    required this.image,
    required this.title,
    required this.quantity,
    required this.price,
    required this.onRemoveFromCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Image.asset(
          image,
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Quantity: $quantity\nPrice: ${price.toStringAsFixed(2)} LE'),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: onRemoveFromCart,
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import '../Database.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ItemDb db = ItemDb();

  @override
  void initState() {
    super.initState();
    debugCartContents(); // Debugging function to print cart contents
  }

  Future<void> debugCartContents() async {
  try {
    final cartItems = await db.getCartItems(); // Fetch cart items from the database
    
    print("=== Cart Table Contents ===");

    if (cartItems.isEmpty) {
      print("Cart is empty.");
    } else {
      for (var item in cartItems) {
        print(
          "ID: ${item['cart_id']}, "
          "Name: ${item['item_name']}, "
          "Quantity: ${item['item_quantity']}, "
          "Price: ${item['item_price']}, "
          "Image: ${item['item_img'] ?? 'No image'}"
        );
      }
    }
    print("===========================");
  } catch (e) {
    print("Error occurred while debugging cart contents: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: const Color(0xFF82CA73),
      ),
      body: Center(
        child: Text('Cart screen is being debugged. Check your console logs.'),
      ),
    );
  }
}
*/