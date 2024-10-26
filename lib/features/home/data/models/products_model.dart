import 'package:app_ecommencer/features/home/domain/entities/products.dart';

class ProductsModel extends Products {
  ProductsModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.precio,
      required super.createdAt,
      required super.imagen});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      precio: json['precio'],
      imagen: json['imagen'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'precio': precio,
        'imagen': imagen,
        'created_at': createdAt,
      };
}
