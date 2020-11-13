import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String id) async {
    final url = 'https://myshop-4938a.firebaseio.com/products/$id';
    var oldState = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final response =
        await http.patch(url, body: json.encode({'isFavorite': isFavorite}));
    if(response.statusCode >= 400){
      isFavorite = oldState;
      notifyListeners();
      throw HttpException('Unable to change favorite state!');
    }
    oldState = null;
  }
}
