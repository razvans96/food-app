import 'package:json_annotation/json_annotation.dart';

part 'simple_product.g.dart';

@JsonSerializable()
class SimpleProduct {

  SimpleProduct({this.name, this.brands});

  factory SimpleProduct.fromJson(Map<String, dynamic> json) =>
      _$SimpleProductFromJson(json);

  final String? name;
  final String? brands;

  /// Generado automáticamente por json_serializable
  Map<String, dynamic> toJson() => _$SimpleProductToJson(this);
}
