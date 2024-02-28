import 'package:flutter/material.dart';
import 'package:products_list/helpers/exception/not_found_exception.dart';
import 'package:products_list/model/products_model.dart';
import 'package:products_list/repositories/products_repositories.dart';

class ProductsStore {
  final IProductsRepositories repository;

  // Variavel reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Variavel reativa para o state
  final ValueNotifier<List<ProductsModel>> state =
      ValueNotifier<List<ProductsModel>>([]);

  // Variavel reativa para o erro
  final ValueNotifier<String> error = ValueNotifier<String>('');

  ProductsStore({required this.repository});

  Future getProducts() async {
    isLoading.value = true;
    try {
      final List<ProductsModel> response = await repository.getProducts();
      state.value = response;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
