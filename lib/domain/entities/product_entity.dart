import 'package:food_app/domain/value_objects/barcode.dart';
import 'package:food_app/domain/value_objects/nutritional_value.dart';
import 'package:meta/meta.dart';

@immutable
class ProductEntity {
  final Barcode barcode;
  final String name;
  final String displayName;
  final String? brand;
  final String? quantity;
  final String? nutriscoreGrade;
  final String? ecoscoreGrade;
  final String? imageUrl;
  final int? novaGroup;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final NutritionalValues? nutritionalValues;
  final List<String>? ingredients;    
  final List<String>? allergens;                
  final List<String>? additives;                  
  final List<String>? categories;

  final bool isHealthy;
  final bool isEcological;
  final String nutritionalQuality;
  final String ecologicalQuality;

  const ProductEntity({
    required this.name, required this.createdAt, required this.isHealthy, required this.isEcological, required this.nutritionalQuality, required this.ecologicalQuality, required this.displayName, 
    required this.barcode,
    this.brand,
    this.quantity,
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.imageUrl,
    this.novaGroup,
    this.updatedAt,
    this.nutritionalValues,
    this.ingredients,
    this.allergens,
    this.additives,
    this.categories,
  });

  
  // Método para crear copia con cambios y así mantener la inmutabilidad
  ProductEntity copyWith({
    Barcode? barcode,
    String? name,
    String? displayName,
    String? brand,
    String? quantity,
    String? nutriscoreGrade,
    String? ecoscoreGrade,
    String? imageUrl,
    int? novaGroup,
    DateTime? createdAt,
    DateTime? updatedAt,
    NutritionalValues? nutritionalValues,
    List<String>? ingredients,
    List<String>? allergens,
    List<String>? additives,
    List<String>? categories,
    bool? isHealthy,
    bool? isEcological,
    String? nutritionalQuality,
    String? ecologicalQuality,
  }) {
    return ProductEntity(
      barcode: barcode ?? this.barcode,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      nutriscoreGrade: nutriscoreGrade ?? this.nutriscoreGrade,
      ecoscoreGrade: ecoscoreGrade ?? this.ecoscoreGrade,
      imageUrl: imageUrl ?? this.imageUrl,
      novaGroup: novaGroup ?? this.novaGroup,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      nutritionalValues: nutritionalValues ?? this.nutritionalValues,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      additives: additives ?? this.additives,
      categories: categories ?? this.categories,
      isHealthy: isHealthy ?? this.isHealthy,
      isEcological: isEcological ?? this.isEcological,
      nutritionalQuality: nutritionalQuality ?? this.nutritionalQuality,
      ecologicalQuality: ecologicalQuality ?? this.ecologicalQuality,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntity &&
          runtimeType == other.runtimeType &&
          barcode == other.barcode &&
          name == other.name;

  @override
  int get hashCode => Object.hash(barcode, name);

  @override
  String toString() => 'ProductEntity(name: $name, brand: $brand, barcode: $barcode)';
}
