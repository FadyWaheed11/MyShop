import 'package:flutter/material.dart';
import 'package:my_shop/provider/products.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';

  Future<void> _fetchData(BuildContext context) async {
    await Provider.of<Products>(context,listen: false).fetchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _fetchData(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  productData.items[i].title,
                  productData.items[i].imageUrl,
                  productData.items[i].id,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
