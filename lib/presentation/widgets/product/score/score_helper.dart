import 'package:flutter/material.dart';
import 'package:food_app/presentation/theme/design_constants.dart';
import 'package:food_app/presentation/theme/theme_extensions.dart';
import 'package:food_app/presentation/widgets/product/score/score_row.dart';

class ScoreData {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color indicatorColor;
  final Color indicatorBorderColor;
  final Color indicatorTextColor;

  const ScoreData({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.indicatorColor,
    required this.indicatorBorderColor,
    required this.indicatorTextColor,
  });
}

class ScoreHelper {
  static ScoreData getScoreData(BuildContext context, ScoreType scoreType, String? scoreValue) {
    final theme = Theme.of(context);
    final foodScoreColors = theme.foodScoreColors;
    
    switch (scoreType) {
      case ScoreType.nutriscore:
        return _getNutriscoreData(foodScoreColors, scoreValue);
      case ScoreType.ecoscore:
        return _getEcoscoreData(foodScoreColors, scoreValue);
      case ScoreType.nova:
        return _getNovaData(foodScoreColors, scoreValue);
    }
  }

  static ScoreData _getNutriscoreData(FoodScoreColors colors, String? score) {
    final indicatorColor = colors.getNutriscoreColor(score);

    return ScoreData(
      backgroundColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityLight),
      borderColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityMedium),
      textColor: Colors.black87,
      indicatorColor: indicatorColor,
      indicatorBorderColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityHeavy),
      indicatorTextColor: indicatorColor.contrastingTextColor,
    );
  }

  static ScoreData _getEcoscoreData(FoodScoreColors colors, String? score) {
    final indicatorColor = colors.getEcoscoreColor(score);

    return ScoreData(
      backgroundColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityLight),
      borderColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityMedium),
      textColor: Colors.black87,
      indicatorColor: indicatorColor,
      indicatorBorderColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityHeavy),
      indicatorTextColor: indicatorColor.contrastingTextColor,
    );
  }

  static ScoreData _getNovaData(FoodScoreColors colors, String? score) {
    final group = int.tryParse(score ?? '');
    final indicatorColor = colors.getNovaColor(group);

    return ScoreData(
      backgroundColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityLight),
      borderColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityMedium),
      textColor: Colors.black87,
      indicatorColor: indicatorColor,
      indicatorBorderColor: indicatorColor.withValues(alpha: AppDesignConstants.opacityHeavy),
      indicatorTextColor: indicatorColor.contrastingTextColor,
    );
  }

  static String getNutriscoreInterpretation(String? score) {
    switch (score?.toUpperCase()) {
      case 'A': return 'Excelente calidad nutricional';
      case 'B': return 'Buena calidad nutricional';
      case 'C': return 'Calidad nutricional aceptable';
      case 'D': return 'Calidad nutricional baja';
      case 'E': return 'Calidad nutricional muy baja';
      default: return 'Calidad nutricional desconocida';
    }
  }

  static String getEcoscoreInterpretation(String? score) {
    switch (score?.toUpperCase()) {
      case 'A': return 'Impacto ambiental muy bajo';
      case 'B': return 'Impacto ambiental bajo';
      case 'C': return 'Impacto ambiental moderado';
      case 'D': return 'Impacto ambiental alto';
      case 'E': return 'Impacto ambiental muy alto';
      default: return 'Impacto ambiental desconocido';
    }
  }

  static String getNovaInterpretation(int? group) {
    switch (group) {
      case 1: return 'Alimentos sin procesar';
      case 2: return 'Ingredientes culinarios procesados';
      case 3: return 'Alimentos procesados';
      case 4: return 'Alimentos ultraprocesados';
      default: return 'Nivel de procesamiento desconocido';
    }
  }
}
