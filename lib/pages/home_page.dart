import 'package:flutter/material.dart';
import 'package:products_list/helpers/store/products_store.dart';
import 'package:products_list/http/http_client.dart';
import 'package:products_list/repositories/products_repositories.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductsStore productsStore = ProductsStore(
    repository: ProductsRepositories(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    productsStore.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Lista de Produtos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          productsStore.isLoading,
          productsStore.state,
          productsStore.error,
        ]),
        builder: (context, child) {
          if (productsStore.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (productsStore.error.value.isNotEmpty) {
            return Center(
              child: Text(
                productsStore.error.value,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }

          if (productsStore.state.value.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum produto encontrado!",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 32,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: productsStore.state.value.length,
              itemBuilder: (_, index) {
                final item = productsStore.state.value[index];
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
