import 'package:flutter_test/flutter_test.dart';
import 'package:products_list/helpers/store/products_store.dart';
import 'package:products_list/http/http_client.dart';
import 'package:products_list/repositories/products_repositories.dart';

void main() {
  testWidgets('products repositories ...', (tester) async {
    final ProductsStore productsRepositories = ProductsStore(
      repository: ProductsRepositories(
        client: HttpClient(),
      ),
    );
    print("TESTE: ${productsRepositories.state.value}");
  });
}
