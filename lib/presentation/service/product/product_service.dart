import 'package:get/get.dart';
import '../../../common/enums/product_category.dart';
import '../../../common/enums/user_role.dart';
import '../../../data/models/product/products.dart';
import '../../../common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../domain/repositories/product_repository_impl.dart';

class ProductService extends GetxService {
  final RxList<Product> simpleProducts = <Product>[].obs;
  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> myProducts = <Product>[].obs;

  final Rx<UserRole> userRole = UserRole.agriculteur.obs;
  final ProductRepository productRepository;

  ProductService({required this.productRepository}) {
    init();
  }

  Future<ProductService> init() async {
    await loadAllProducts();
    return this;
  }

  Future<void> loadAllProducts() async {
    final result = await productRepository.getAllProducts();
    result.fold(
      (failure) => Get.snackbar("Erreur", failure.message),
      (data) {
        final products = data.map((e) => Product.fromJson(e)).toList();
        allProducts.assignAll(products);
        simpleProducts.assignAll(products);
      },
    );
  }

  Future<void> loadProductsBySeller(String sellerId) async {
    final result = await productRepository.getProductsBySeller(sellerId);
    result.fold(
      (failure) {
        Get.snackbar("Erreur", failure.message);
        myProducts.clear();
        simpleProducts.clear();
      },
      (data) {
        final products = data.map((e) => Product.fromJson(e)).toList();
        myProducts.assignAll(products);
        simpleProducts.assignAll(products);
      },
    );
  }

  Future<Either<Failure, String>> deleteProduct(dynamic id) {
    return productRepository.deleteProduct(id.toString());
  }

  void setUserRole(UserRole role) {
    userRole.value = role;
  }

  UserRole getUserRole() {
    return userRole.value;
  }

  void addProduct(Product product) {
    simpleProducts.add(product);
  }
}
