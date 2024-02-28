// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:products_list/helpers/store/products_store.dart';
import 'package:products_list/http/http_client.dart';
import 'package:products_list/repositories/products_repositories.dart';

void main() {
  testWidgets('products repositories ...', (tester) async {
    final ProductsStore productsStore = ProductsStore(
      repository: ProductsRepositories(
        client: HttpClient(),
      ),
    );

    if (productsStore.state.value.isNotEmpty) {
      print("LISTA DE PRODUTOS");
      print(productsStore.state.value);
    } else {
      print("NENHUM PRODUTO NA LISTA");
      print(productsStore.state.value);
    }
  });
}
