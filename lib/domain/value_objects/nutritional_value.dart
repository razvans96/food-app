import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'nutritional_value.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class NutritionalValues {
  final EnergyValue? energy;
  final NutrientValue? fat;
  @JsonKey(name: 'saturated_fat')
  final NutrientValue? saturatedFat;
  final NutrientValue? carbohydrates;
  final NutrientValue? sugars;
  final NutrientValue? fiber;
  final NutrientValue? proteins;
  final NutrientValue? salt;
  final NutrientValue? sodium;
  final NutrientValue? calcium;
  final NutrientValue? iron;
  @JsonKey(name: 'vitamin_c')
  final NutrientValue? vitaminC;

  const NutritionalValues({
    this.energy,
    this.fat,
    this.saturatedFat,
    this.carbohydrates,
    this.sugars,
    this.fiber,
    this.proteins,
    this.salt,
    this.sodium,
    this.calcium,
    this.iron,
    this.vitaminC,
  });

  factory NutritionalValues.fromJson(Map<String, dynamic> json) => 
      _$NutritionalValuesFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionalValuesToJson(this);

}

@JsonSerializable()
@immutable
class EnergyValue {
  @JsonKey(name: 'value_kj')
  final double valueKj;

  @JsonKey(name: 'value_kcal')
  final double valueKcal;

  const EnergyValue({required this.valueKj, required this.valueKcal});

  factory EnergyValue.fromJson(Map<String, dynamic> json) => 
      _$EnergyValueFromJson(json);

  Map<String, dynamic> toJson() => _$EnergyValueToJson(this);
}

@JsonSerializable()
@immutable
class NutrientValue {
  final double value;
  final String unit;


  const NutrientValue({
    required this.value,
    required this.unit,
  });

  factory NutrientValue.fromJson(Map<String, dynamic> json) => 
      _$NutrientValueFromJson(json);

  Map<String, dynamic> toJson() => _$NutrientValueToJson(this);
}
