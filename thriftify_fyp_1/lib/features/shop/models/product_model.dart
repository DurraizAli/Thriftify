import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String price;
  final String brand;
  final String description;
  final String category;
  final String phone;
  final List<String> imageUrls;
  final DateTime? createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.phone,
    required this.imageUrls,
    required this.createdAt,
    required this.brand,
  });

  factory ProductModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      price: data['price'] != null ? data['price'].toString() : '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      phone: data['phone'] ?? '',
      imageUrls:
          data['imageUrls'] != null ? List<String>.from(data['imageUrls']) : [],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      brand: data['brand'] ?? '',
    );
  }
}
