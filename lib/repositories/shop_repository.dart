import '../services/api_client.dart';

/// A catalog item available for purchase through the shop.
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.basePrice,
    required this.unit,
    this.description,
    this.imageUrl,
    this.isFeatured = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      basePrice: (json['base_price'] as num).toDouble(),
      unit: json['unit'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      isFeatured: json['is_featured'] as bool? ?? false,
    );
  }

  final String id;
  final String name;
  final String category;
  final double basePrice;
  final String unit;
  final String? description;
  final String? imageUrl;
  final bool isFeatured;
}

/// A material/hardware dealer whose prices are aggregated in the shop.
class Dealer {
  const Dealer({
    required this.id,
    required this.name,
    this.logoUrl,
    this.address,
    this.rating,
  });

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      id: json['id'] as String,
      name: json['name'] as String,
      logoUrl: json['logo_url'] as String?,
      address: json['address'] as String?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
    );
  }

  final String id;
  final String name;
  final String? logoUrl;
  final String? address;
  final double? rating;
}

/// A dealer-specific price quote for a single [Product].
class DealerPrice {
  const DealerPrice({
    required this.dealerId,
    required this.dealerName,
    required this.productId,
    required this.price,
    required this.inStock,
    this.updatedAt,
  });

  factory DealerPrice.fromJson(Map<String, dynamic> json) {
    return DealerPrice(
      dealerId: json['dealer_id'] as String,
      dealerName: json['dealer_name'] as String,
      productId: json['product_id'] as String,
      price: (json['price'] as num).toDouble(),
      inStock: json['in_stock'] as bool? ?? true,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  final String dealerId;
  final String dealerName;
  final String productId;
  final double price;
  final bool inStock;
  final DateTime? updatedAt;
}

/// Read-only access to the shop catalog. The catalog itself (products,
/// dealers, pricing) is managed entirely on the backend; the app only reads.
abstract interface class ShopRepository {
  Future<List<Product>> getProducts({int page = 1, int limit = 20});
  Future<List<Product>> searchProducts(String query);
  Future<Product> getProductById(String id);
  Future<List<Dealer>> getDealers();
  Future<List<DealerPrice>> getDealerPrices(String productId);
  Future<List<String>> getCategories();
  Future<List<Product>> getFeatured();
}

class ShopRepositoryImpl implements ShopRepository {
  ShopRepositoryImpl(this._apiClient);

  final ApiClient _apiClient;

  // ApiClient is configured with AppConfig.apiUrl, which already includes
  // the `/api/v1` prefix, so paths here are relative to that base.
  static const _productsPath = '/shop/products';
  static const _dealersPath = '/shop/dealers';

  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 20}) async {
    try {
      return await _apiClient.get<List<Product>>(
        _productsPath,
        queryParameters: {'page': page, 'limit': limit},
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw ShopException(e.message);
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      return await _apiClient.get<List<Product>>(
        '$_productsPath/search',
        queryParameters: {'q': query},
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw ShopException(e.message);
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      return await _apiClient.get<Product>(
        '$_productsPath/$id',
        fromJson: (json) => Product.fromJson(json as Map<String, dynamic>),
      );
    } on ApiException catch (e) {
      throw ShopException(e.message);
    }
  }

  @override
  Future<List<Dealer>> getDealers() async {
    try {
      return await _apiClient.get<List<Dealer>>(
        _dealersPath,
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => Dealer.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw ShopException(e.message);
    }
  }

  @override
  Future<List<DealerPrice>> getDealerPrices(String productId) async {
    try {
      return await _apiClient.get<List<DealerPrice>>(
        '$_productsPath/$productId/prices',
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => DealerPrice.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw ShopException(e.message);
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      return await _apiClient.get<List<String>>(
        '/shop/categories',
        fromJson: (json) =>
            (json as List<dynamic>).map((e) => e as String).toList(),
      );
    } on ApiException catch (e) {
      throw ShopException(e.message);
    }
  }

  @override
  Future<List<Product>> getFeatured() async {
    try {
      return await _apiClient.get<List<Product>>(
        '$_productsPath/featured',
        fromJson: (json) => (json as List<dynamic>)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on ApiException catch (e) {
      throw ShopException(e.message);
    }
  }
}

class ShopException implements Exception {
  ShopException(this.message);
  final String message;

  @override
  String toString() => message;
}
