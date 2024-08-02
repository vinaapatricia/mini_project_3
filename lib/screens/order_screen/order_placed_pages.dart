import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderPlacedPages extends StatefulWidget {
  const OrderPlacedPages({super.key});

  @override
  _OrderPlacedPagesState createState() => _OrderPlacedPagesState();
}

class _OrderPlacedPagesState extends State<OrderPlacedPages>
    with SingleTickerProviderStateMixin {
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection("MinPro3");

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed'),
        bottom: TabBar(
          indicatorColor: Colors.green,
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Belum Bayar'),
            Tab(text: 'Dikemas'),
            Tab(text: 'Dikirim'),
            Tab(text: 'Selesai'),
            Tab(text: 'Pengembalian'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderList(status: 'Belum Bayar', ordersCollection: ordersCollection),
          OrderList(status: 'Dikemas', ordersCollection: ordersCollection),
          OrderList(status: 'Dikirim', ordersCollection: ordersCollection),
          OrderList(status: 'Selesai', ordersCollection: ordersCollection),
          OrderList(status: 'Pengembalian', ordersCollection: ordersCollection),
        ],
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String status;
  final CollectionReference ordersCollection;

  const OrderList({required this.status, required this.ordersCollection});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ordersCollection.where('status', isEqualTo: status).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var orders = snapshot.data!.docs;
          if (status == 'Dikemas') {
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(order['imageurl']),
                    title: Text(order['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\$${order['price'].toString()}'),
                        Text('Status: Dikemas'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
