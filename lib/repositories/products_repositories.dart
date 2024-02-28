import 'dart:convert';

import 'package:products_list/helpers/exception/not_found_exception.dart';
import 'package:products_list/http/http_client.dart';
import 'package:products_list/model/products_model.dart';

abstract class IProductsRepositories {
  Future<List<ProductsModel>> getProducts();
}

class ProductsRepositories implements IProductsRepositories {
  final IHttpClient client;

  ProductsRepositories({required this.client});

  @override
  Future<List<ProductsModel>> getProducts() async {
    final responseApi = await client.get(url: 'https://dummyjson.com/products');

    if (responseApi.statusCode == 200) {
      final List<ProductsModel> products = [];
      final body = jsonDecode(responseApi.body);
      body['products'].map((item) {
        final ProductsModel product = ProductsModel.fromMap(item);
        products.add(product);
      }).toList();

      return products;
    } else if (responseApi.statusCode == 404) {
      throw NotFoundException(message: "A URL informada não é válida.");
    } else {
      throw Exception("Não foi possivel carregar os produtos.");
    }
  }
}
