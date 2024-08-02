import 'package:flutter/material.dart';
import 'package:mini_project_3/screens/order_screen/order_placed_pages.dart';

class CheckoutPages extends StatelessWidget {
  const CheckoutPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('still emptyyyyy'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ElevatedButton.styleFrom(backgroundColor: Colors.green);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderPlacedPages(),
              ),
            );
          },
          child: Text(
            'go to order placed now',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ]),
    ));
  }
}
