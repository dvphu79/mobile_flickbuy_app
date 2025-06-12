import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flickbuy_app/src/core/providers/appwrite_provider.dart';
import 'package:mobile_flickbuy_app/src/features/products/domain/product.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final databases = ref.watch(appwriteDatabasesProvider);
  return ProductsRepository(databases);
});

class ProductsRepository {
  final Databases _databases;

  ProductsRepository(this._databases);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: appwriteDatabaseId,
        collectionId: appwriteProductsCollectionId,
      );
      return response.documents
          .map((doc) => Product.fromJson(doc.data))
          .toList();
    } on AppwriteException catch (e) {
      // Log the error or handle it more gracefully
      print('AppwriteException in fetchProducts: ${e.message}');
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }

  Future<Product> fetchProduct(String id) async {
    try {
      final response = await _databases.getDocument(
        databaseId: appwriteDatabaseId,
        collectionId: appwriteProductsCollectionId,
        documentId: id,
      );
      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch product $id: $e');
    }
  }
}
