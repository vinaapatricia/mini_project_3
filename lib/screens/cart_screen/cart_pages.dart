import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_3/screens/order_screen/checkout_pages.dart';

class CartPages extends StatefulWidget {
  const CartPages({super.key});

  @override
  _CartPagesState createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  final CollectionReference cart =
      FirebaseFirestore.instance.collection("MinPro3");

  double get totalAmount {
    double total = 0.0;
    cartItems.forEach((item) {
      total += 3000;
    });
    return total;
  }

  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  void _fetchCartItems() async {
    QuerySnapshot querySnapshot = await cart.get();
    setState(() {
      cartItems = querySnapshot.docs.map((doc) {
        return {
          'title': doc['title'],
          'price': doc['price'].toString(),
          'quantity': 1,
          'imageUrl': doc['imageurl'],
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Keranjang belanja Anda kosong.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.network(item['imageUrl']),
                        title: Text(item['title']),
                        subtitle:
                            Text('Jumlah: ${item['quantity'].toString()}'),
                        trailing: Text(
                            '\$${(item['price'].toString() * item['quantity'])}'),
                        onTap: () {},
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: \$${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          ElevatedButton.styleFrom(
                              backgroundColor: Colors.green);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPages(),
                            ),
                          );
                        },
                        child: const Text(
                          'Checkout',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
