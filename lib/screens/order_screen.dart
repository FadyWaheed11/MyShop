import 'package:flutter/material.dart';
import 'package:my_shop/provider/orders.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/order_tile.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
        builder: (context, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataSnapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          }
          return Consumer<Orders>(
            builder: (context, orderData, child) {
              return ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (context, i) => OrderTile(orderData.orders[i]),
              );
            },
          );
        },
      ),
    );
  }
}
