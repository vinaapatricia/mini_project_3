import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_3/screens/cart_screen/cart_pages.dart';
import 'package:mini_project_3/screens/product_screen/product_detail_page.dart';

Widget _buildCategoryItem(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Chip(
      backgroundColor: Colors.transparent,
      label: Text(title),
    ),
  );
}

class ProductPages extends StatefulWidget {
  const ProductPages({super.key});

  @override
  State<ProductPages> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProductPages> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection("MinPro3");

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.green[700],
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Product...',
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              onChanged: (value) {},
            ),
          ),
          actions: [
            IconButton(
              icon: const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: Icon(Icons.messenger_outline),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: Icon(Icons.notifications_none),
              ),
              onPressed: () {
                // notif helper
              },
            ),
            IconButton(
              icon: const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: Icon(Icons.shopping_cart),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPages(),
                  ),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 30.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _buildCategoryItem('For You'),
                    _buildCategoryItem('Beli Lokal'),
                    _buildCategoryItem('Baju Pria'),
                    _buildCategoryItem('Baju Anak'),
                    _buildCategoryItem('Perabotan'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            List<DocumentSnapshot> filteredProducts = streamSnapshot.data!.docs
                .where((doc) => doc['title']
                    .toString()
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()))
                .toList();

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    filteredProducts[index];
                return ItemsDisplay(context, documentSnapshot);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  GestureDetector ItemsDisplay(
      BuildContext context, DocumentSnapshot<Object?> documentSnapshot) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailPage(product: documentSnapshot)));
      },
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: documentSnapshot['imageurl'],
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(
                      documentSnapshot['imageurl'],
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                documentSnapshot['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$ ${documentSnapshot['price'].toString()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${documentSnapshot['rate']} • ${documentSnapshot['count']}+ terjual',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
