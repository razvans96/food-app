import 'package:flutter/material.dart';
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
  static const Color _nutriscoreA = Color(0xFF038141);
  static const Color _nutriscoreB = Color(0xFF85bb2f);
  static const Color _nutriscoreC = Color(0xFFfecb02);
  static const Color _nutriscoreD = Color(0xFFee8100);
  static const Color _nutriscoreE = Color(0xFFe63e11);

  static const Color _ecoscoreA = Color(0xFF00a950);
  static const Color _ecoscoreB = Color(0xFF84b84c);
  static const Color _ecoscoreC = Color(0xFFf4d03f);
  static const Color _ecoscoreD = Color(0xFFf39c12);
  static const Color _ecoscoreE = Color(0xFFe74c3c);

  static const Color _nova1 = Color(0xFF27ae60);
  static const Color _nova2 = Color(0xFFf1c40f);
  static const Color _nova3 = Color(0xFFe67e22);
  static const Color _nova4 = Color(0xFFe74c3c);

  static ScoreData getScoreData(ScoreType scoreType, String? scoreValue) {
    switch (scoreType) {
      case ScoreType.nutriscore:
        return _getNutriscoreData(scoreValue);
      case ScoreType.ecoscore:
        return _getEcoscoreData(scoreValue);
      case ScoreType.nova:
        return _getNovaData(scoreValue);
    }
  }

  static ScoreData _getNutriscoreData(String? score) {
    Color indicatorColor;
    
    switch (score?.toUpperCase()) {
      case 'A':
        indicatorColor = _nutriscoreA;
      case 'B':
        indicatorColor = _nutriscoreB;
      case 'C':
        indicatorColor = _nutriscoreC;
      case 'D':
        indicatorColor = _nutriscoreD;
      case 'E':
        indicatorColor = _nutriscoreE;
      default:
        indicatorColor = Colors.grey[400]!;
    }

    return ScoreData(
      backgroundColor: indicatorColor.withValues(alpha: 0.1),
      borderColor: indicatorColor.withValues(alpha: 0.3),
      textColor: Colors.black87,
      indicatorColor: indicatorColor,
      indicatorBorderColor: indicatorColor.withValues(alpha: 0.7),
      indicatorTextColor: _getContrastingTextColor(indicatorColor),
    );
  }

  static ScoreData _getEcoscoreData(String? score) {
    Color indicatorColor;
    
    switch (score?.toUpperCase()) {
      case 'A':
        indicatorColor = _ecoscoreA;
      case 'B':
        indicatorColor = _ecoscoreB;
      case 'C':
        indicatorColor = _ecoscoreC;
      case 'D':
        indicatorColor = _ecoscoreD;
      case 'E':
        indicatorColor = _ecoscoreE;
      default:
        indicatorColor = Colors.grey[400]!;
    }

    return ScoreData(
      backgroundColor: indicatorColor.withValues(alpha: 0.1),
      borderColor: indicatorColor.withValues(alpha: 0.3),
      textColor: Colors.black87,
      indicatorColor: indicatorColor,
      indicatorBorderColor: indicatorColor.withValues(alpha: 0.7),
      indicatorTextColor: _getContrastingTextColor(indicatorColor),
    );
  }

  static ScoreData _getNovaData(String? score) {
    Color indicatorColor;
    
    switch (score) {
      case '1':
        indicatorColor = _nova1;
      case '2':
        indicatorColor = _nova2;
      case '3':
        indicatorColor = _nova3;
      case '4':
        indicatorColor = _nova4;
      default:
        indicatorColor = Colors.grey[400]!;
    }

    return ScoreData(
      backgroundColor: indicatorColor.withValues(alpha: 0.1),
      borderColor: indicatorColor.withValues(alpha: 0.3),
      textColor: Colors.black87,
      indicatorColor: indicatorColor,
      indicatorBorderColor: indicatorColor.withValues(alpha: 0.7),
      indicatorTextColor: _getContrastingTextColor(indicatorColor),
    );
  }

  static Color _getContrastingTextColor(Color backgroundColor) {
    // Calcular luminancia para determinar si usar texto blanco o negro
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }


  static String getNutriscoreInterpretation(String? score) {
    switch (score?.toUpperCase()) {
      case 'A':
        return 'Excelente calidad nutricional';
      case 'B':
        return 'Buena calidad nutricional';
      case 'C':
        return 'Calidad nutricional aceptable';
      case 'D':
        return 'Calidad nutricional baja';
      case 'E':
        return 'Calidad nutricional muy baja';
      default:
        return 'Calidad nutricional desconocida';
    }
  }

  static String getEcoscoreInterpretation(String? score) {
    switch (score?.toUpperCase()) {
      case 'A':
        return 'Impacto ambiental muy bajo';
      case 'B':
        return 'Impacto ambiental bajo';
      case 'C':
        return 'Impacto ambiental moderado';
      case 'D':
        return 'Impacto ambiental alto';
      case 'E':
        return 'Impacto ambiental muy alto';
      default:
        return 'Impacto ambiental desconocido';
    }
  }

  static String getNovaInterpretation(int? group) {
    switch (group) {
      case 1:
        return 'Alimentos sin procesar';
      case 2:
        return 'Ingredientes culinarios procesados';
      case 3:
        return 'Alimentos procesados';
      case 4:
        return 'Alimentos ultraprocesados';
      default:
        return 'Nivel de procesamiento desconocido';
    }
  }
}
