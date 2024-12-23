import 'package:flutter/material.dart';
import '../Database.dart';

class CheckoutScreen extends StatelessWidget {
  final double totalPrice;
  final List<Map<String, dynamic>> cartItems;
  final String username;
  const   CheckoutScreen({
    required this.totalPrice,
    required this.cartItems,
    required this.username,
  });

  Future<void> placeOrder(BuildContext context) async {
    final ItemDb db = ItemDb();
    try {
      // Simulate placing the order
      await Future.delayed(const Duration(seconds: 2));

      // Clear the cart in the database
      await db.clearCart(username);

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );

      // Navigate back to the cart screen
      Navigator.pop(context); // This will trigger a refresh in the cart screen
    } catch (e) {
      // Handle any errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFF82CA73),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.asset(
                      item['item_img'],
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['item_name']),
                    subtitle: Text(
                      'Quantity: ${item['item_quantity']} - Price: ${item['item_price'].toStringAsFixed(2)} LE',
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalPrice.toStringAsFixed(2)} LE',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => placeOrder(context),
                child: const Text('Place Order'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  backgroundColor: const Color(0xFF82CA73),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
