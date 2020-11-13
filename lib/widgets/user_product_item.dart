import 'package:flutter/material.dart';
import 'package:my_shop/provider/products.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  UserProductItem(this.title, this.imageUrl, this.id);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100.0,
        child: Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName,
                      arguments: id);
                }),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .removeProduct(id);
                  } catch (_) {
                    scaffold.showSnackBar(
                      SnackBar(
                          content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      )),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
