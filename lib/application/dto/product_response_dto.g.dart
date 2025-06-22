// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseDto _$ProductResponseDtoFromJson(Map<String, dynamic> json) =>
    ProductResponseDto(
      name: json['name'] as String,
      nutritionalQuality: json['nutritional_quality'] as String,
      ecologicalQuality: json['ecological_quality'] as String,
      isHealthy: json['is_healthy'] as bool,
      isEcological: json['is_ecological'] as bool,
      displayName: json['display_name'] as String,
      barcode: json['barcode'] as String,
      brand: json['brand'] as String?,
      quantity: json['quantity'] as String?,
      imageUrl: json['image_url'] as String?,
      nutriscoreGrade: json['nutriscore_grade'] as String?,
      ecoscoreGrade: json['ecoscore_grade'] as String?,
      novaGroup: (json['nova_group'] as num?)?.toInt(),
      nutritionalValues: json['nutritional_values'] == null
          ? null
          : NutritionalValues.fromJson(
              json['nutritional_values'] as Map<String, dynamic>),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allergens: (json['allergens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      additives: (json['additives'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ProductResponseDtoToJson(ProductResponseDto instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'name': instance.name,
      'brand': instance.brand,
      'quantity': instance.quantity,
      'image_url': instance.imageUrl,
      'nutriscore_grade': instance.nutriscoreGrade,
      'ecoscore_grade': instance.ecoscoreGrade,
      'nova_group': instance.novaGroup,
      'nutritional_quality': instance.nutritionalQuality,
      'ecological_quality': instance.ecologicalQuality,
      'is_healthy': instance.isHealthy,
      'is_ecological': instance.isEcological,
      'display_name': instance.displayName,
      'nutritional_values': instance.nutritionalValues?.toJson(),
      'ingredients': instance.ingredients,
      'allergens': instance.allergens,
      'additives': instance.additives,
      'categories': instance.categories,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
