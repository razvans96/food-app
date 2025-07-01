import 'package:flutter/material.dart';

class FoodScoreColors extends ThemeExtension<FoodScoreColors> {
  final Color nutriscoreA;
  final Color nutriscoreB;
  final Color nutriscoreC;
  final Color nutriscoreD;
  final Color nutriscoreE;

  final Color ecoscoreA;
  final Color ecoscoreB;
  final Color ecoscoreC;
  final Color ecoscoreD;
  final Color ecoscoreE;

  final Color nova1;
  final Color nova2;
  final Color nova3;
  final Color nova4;

  final Color unknown;

  const FoodScoreColors({
    required this.nutriscoreA,
    required this.nutriscoreB,
    required this.nutriscoreC,
    required this.nutriscoreD,
    required this.nutriscoreE,
    required this.ecoscoreA,
    required this.ecoscoreB,
    required this.ecoscoreC,
    required this.ecoscoreD,
    required this.ecoscoreE,
    required this.nova1,
    required this.nova2,
    required this.nova3,
    required this.nova4,
    required this.unknown,
  });

  static const FoodScoreColors light = FoodScoreColors(
    nutriscoreA: Color(0xFF038141),
    nutriscoreB: Color(0xFF85bb2f),
    nutriscoreC: Color(0xFFfecb02),
    nutriscoreD: Color(0xFFee8100),
    nutriscoreE: Color(0xFFe63e11),
    
    ecoscoreA: Color(0xFF00a950),
    ecoscoreB: Color(0xFF84b84c),
    ecoscoreC: Color(0xFFf4d03f),
    ecoscoreD: Color(0xFFf39c12),
    ecoscoreE: Color(0xFFe74c3c),

    nova1: Color(0xFF27ae60),
    nova2: Color(0xFFf1c40f),
    nova3: Color(0xFFe67e22),
    nova4: Color(0xFFe74c3c),

    unknown: Color(0xFF9e9e9e),
  );

  static const FoodScoreColors dark = FoodScoreColors(
    nutriscoreA: Color(0xFF4caf50),
    nutriscoreB: Color(0xFF8bc34a),
    nutriscoreC: Color(0xFFffeb3b),
    nutriscoreD: Color(0xFFff9800),
    nutriscoreE: Color(0xFFf44336),
    
    ecoscoreA: Color(0xFF2e7d32),
    ecoscoreB: Color(0xFF689f38),
    ecoscoreC: Color(0xFFf57f17),
    ecoscoreD: Color(0xFFe65100),
    ecoscoreE: Color(0xFFd32f2f),
    
    nova1: Color(0xFF4caf50),
    nova2: Color(0xFFffeb3b),
    nova3: Color(0xFFff9800),
    nova4: Color(0xFFf44336),
    
    unknown: Color(0xFF757575),
  );

  Color getNutriscoreColor(String? score) {
    switch (score?.toUpperCase()) {
      case 'A': return nutriscoreA;
      case 'B': return nutriscoreB;
      case 'C': return nutriscoreC;
      case 'D': return nutriscoreD;
      case 'E': return nutriscoreE;
      default: return unknown;
    }
  }

  Color getEcoscoreColor(String? score) {
    switch (score?.toUpperCase()) {
      case 'A': return ecoscoreA;
      case 'B': return ecoscoreB;
      case 'C': return ecoscoreC;
      case 'D': return ecoscoreD;
      case 'E': return ecoscoreE;
      default: return unknown;
    }
  }

  Color getNovaColor(int? group) {
    switch (group) {
      case 1: return nova1;
      case 2: return nova2;
      case 3: return nova3;
      case 4: return nova4;
      default: return unknown;
    }
  }

  @override
  FoodScoreColors copyWith({
    Color? nutriscoreA,
    Color? nutriscoreB,
    Color? nutriscoreC,
    Color? nutriscoreD,
    Color? nutriscoreE,
    Color? ecoscoreA,
    Color? ecoscoreB,
    Color? ecoscoreC,
    Color? ecoscoreD,
    Color? ecoscoreE,
    Color? nova1,
    Color? nova2,
    Color? nova3,
    Color? nova4,
    Color? unknown,
  }) {
    return FoodScoreColors(
      nutriscoreA: nutriscoreA ?? this.nutriscoreA,
      nutriscoreB: nutriscoreB ?? this.nutriscoreB,
      nutriscoreC: nutriscoreC ?? this.nutriscoreC,
      nutriscoreD: nutriscoreD ?? this.nutriscoreD,
      nutriscoreE: nutriscoreE ?? this.nutriscoreE,
      ecoscoreA: ecoscoreA ?? this.ecoscoreA,
      ecoscoreB: ecoscoreB ?? this.ecoscoreB,
      ecoscoreC: ecoscoreC ?? this.ecoscoreC,
      ecoscoreD: ecoscoreD ?? this.ecoscoreD,
      ecoscoreE: ecoscoreE ?? this.ecoscoreE,
      nova1: nova1 ?? this.nova1,
      nova2: nova2 ?? this.nova2,
      nova3: nova3 ?? this.nova3,
      nova4: nova4 ?? this.nova4,
      unknown: unknown ?? this.unknown,
    );
  }

  @override
  FoodScoreColors lerp(FoodScoreColors? other, double t) {
    if (other is! FoodScoreColors) return this;
    return FoodScoreColors(
      nutriscoreA: Color.lerp(nutriscoreA, other.nutriscoreA, t)!,
      nutriscoreB: Color.lerp(nutriscoreB, other.nutriscoreB, t)!,
      nutriscoreC: Color.lerp(nutriscoreC, other.nutriscoreC, t)!,
      nutriscoreD: Color.lerp(nutriscoreD, other.nutriscoreD, t)!,
      nutriscoreE: Color.lerp(nutriscoreE, other.nutriscoreE, t)!,
      ecoscoreA: Color.lerp(ecoscoreA, other.ecoscoreA, t)!,
      ecoscoreB: Color.lerp(ecoscoreB, other.ecoscoreB, t)!,
      ecoscoreC: Color.lerp(ecoscoreC, other.ecoscoreC, t)!,
      ecoscoreD: Color.lerp(ecoscoreD, other.ecoscoreD, t)!,
      ecoscoreE: Color.lerp(ecoscoreE, other.ecoscoreE, t)!,
      nova1: Color.lerp(nova1, other.nova1, t)!,
      nova2: Color.lerp(nova2, other.nova2, t)!,
      nova3: Color.lerp(nova3, other.nova3, t)!,
      nova4: Color.lerp(nova4, other.nova4, t)!,
      unknown: Color.lerp(unknown, other.unknown, t)!,
    );
  }
}

class AdditiveColors extends ThemeExtension<AdditiveColors> {
  final Color colorants;    
  final Color preservatives;
  final Color antioxidants;
  final Color stabilizers;
  final Color acidityRegulators;
  final Color flavorEnhancers;
  final Color sweeteners;      
  final Color others;

  const AdditiveColors({
    required this.colorants,
    required this.preservatives,
    required this.antioxidants,
    required this.stabilizers,
    required this.acidityRegulators,
    required this.flavorEnhancers,
    required this.sweeteners,
    required this.others,
  });

  static const AdditiveColors light = AdditiveColors(
    colorants: Color(0xFF2196f3),
    preservatives: Color(0xFF4caf50),
    antioxidants: Color(0xFFff9800),
    stabilizers: Color(0xFFf44336),
    acidityRegulators: Color(0xFF9c27b0),
    flavorEnhancers: Color(0xFF3f51b5),
    sweeteners: Color(0xFFe91e63),
    others: Color(0xFF607d8b),
  );

  static const AdditiveColors dark = AdditiveColors(
    colorants: Color(0xFF42a5f5),
    preservatives: Color(0xFF66bb6a),
    antioxidants: Color(0xFFffb74d),
    stabilizers: Color(0xFFef5350),
    acidityRegulators: Color(0xFFba68c8),
    flavorEnhancers: Color(0xFF7986cb),
    sweeteners: Color(0xFFf06292),
    others: Color(0xFF78909c),
  );

  Color getAdditiveColor(String code) {
    final codeNumber = int.tryParse(code.replaceAll('E', '')) ?? 0;
    
    if (codeNumber >= 100 && codeNumber < 200) return colorants;
    if (codeNumber >= 200 && codeNumber < 300) return preservatives;
    if (codeNumber >= 300 && codeNumber < 400) return antioxidants;
    if (codeNumber >= 400 && codeNumber < 500) return stabilizers;
    if (codeNumber >= 500 && codeNumber < 600) return acidityRegulators;
    if (codeNumber >= 600 && codeNumber < 700) return flavorEnhancers;
    if (codeNumber >= 900 && codeNumber < 1000) return sweeteners;
    return others;
  }

  @override
  AdditiveColors copyWith({
    Color? colorants,
    Color? preservatives,
    Color? antioxidants,
    Color? stabilizers,
    Color? acidityRegulators,
    Color? flavorEnhancers,
    Color? sweeteners,
    Color? others,
  }) {
    return AdditiveColors(
      colorants: colorants ?? this.colorants,
      preservatives: preservatives ?? this.preservatives,
      antioxidants: antioxidants ?? this.antioxidants,
      stabilizers: stabilizers ?? this.stabilizers,
      acidityRegulators: acidityRegulators ?? this.acidityRegulators,
      flavorEnhancers: flavorEnhancers ?? this.flavorEnhancers,
      sweeteners: sweeteners ?? this.sweeteners,
      others: others ?? this.others,
    );
  }

  @override
  AdditiveColors lerp(AdditiveColors? other, double t) {
    if (other is! AdditiveColors) return this;
    return AdditiveColors(
      colorants: Color.lerp(colorants, other.colorants, t)!,
      preservatives: Color.lerp(preservatives, other.preservatives, t)!,
      antioxidants: Color.lerp(antioxidants, other.antioxidants, t)!,
      stabilizers: Color.lerp(stabilizers, other.stabilizers, t)!,
      acidityRegulators: Color.lerp(acidityRegulators, other.acidityRegulators, t)!,
      flavorEnhancers: Color.lerp(flavorEnhancers, other.flavorEnhancers, t)!,
      sweeteners: Color.lerp(sweeteners, other.sweeteners, t)!,
      others: Color.lerp(others, other.others, t)!,
    );
  }
}

class AllergenColors extends ThemeExtension<AllergenColors> {
  final Color gluten;
  final Color dairy;
  final Color eggs;
  final Color nuts;
  final Color fish;
  final Color shellfish;
  final Color soy;
  final Color celery;
  final Color mustard;
  final Color sesame;
  final Color sulfites;
  final Color lupin;
  final Color general;

  const AllergenColors({
    required this.gluten,
    required this.dairy,
    required this.eggs,
    required this.nuts,
    required this.fish,
    required this.shellfish,
    required this.soy,
    required this.celery,
    required this.mustard,
    required this.sesame,
    required this.sulfites,
    required this.lupin,
    required this.general,
  });

  static const AllergenColors light = AllergenColors(
    gluten: Color(0xFFd32f2f),
    dairy: Color(0xFF1976d2),
    eggs: Color(0xFFffa000),
    nuts: Color(0xFF8d6e63),
    fish: Color(0xFF0097a7),
    shellfish: Color(0xFF7b1fa2),
    soy: Color(0xFF689f38),
    celery: Color(0xFF4caf50),
    mustard: Color(0xFFfbc02d),
    sesame: Color(0xFFff8f00),
    sulfites: Color(0xFF5d4037),
    lupin: Color(0xFF512da8),
    general: Color(0xFFe53935),
  );

  static const AllergenColors dark = AllergenColors(
    gluten: Color(0xFFef5350),
    dairy: Color(0xFF42a5f5),
    eggs: Color(0xFFffb74d),
    nuts: Color(0xFFa1887f),
    fish: Color(0xFF26c6da),
    shellfish: Color(0xFF9575cd),
    soy: Color(0xFF8bc34a),
    celery: Color(0xFF66bb6a),
    mustard: Color(0xFFfff176),
    sesame: Color(0xFFffb74d),
    sulfites: Color(0xFF8d6e63),
    lupin: Color(0xFF7986cb),
    general: Color(0xFFef5350),
  );

  Color getAllergenColor(String allergen) {
    final allergenLower = allergen.toLowerCase();
    
    if (allergenLower.contains('gluten')) return gluten;
    if (allergenLower.contains('leche') || allergenLower.contains('lácteos')) return dairy;
    if (allergenLower.contains('huevo')) return eggs;
    if (allergenLower.contains('frutos secos') || allergenLower.contains('nueces')) return nuts;
    if (allergenLower.contains('pescado')) return fish;
    if (allergenLower.contains('marisco') || allergenLower.contains('crustáceos')) return shellfish;
    if (allergenLower.contains('soja')) return soy;
    if (allergenLower.contains('apio')) return celery;
    if (allergenLower.contains('mostaza')) return mustard;
    if (allergenLower.contains('sésamo')) return sesame;
    if (allergenLower.contains('sulfitos')) return sulfites;
    if (allergenLower.contains('altramuces')) return lupin;
    return general;
  }

  @override
  AllergenColors copyWith({
    Color? gluten,
    Color? dairy,
    Color? eggs,
    Color? nuts,
    Color? fish,
    Color? shellfish,
    Color? soy,
    Color? celery,
    Color? mustard,
    Color? sesame,
    Color? sulfites,
    Color? lupin,
    Color? general,
  }) {
    return AllergenColors(
      gluten: gluten ?? this.gluten,
      dairy: dairy ?? this.dairy,
      eggs: eggs ?? this.eggs,
      nuts: nuts ?? this.nuts,
      fish: fish ?? this.fish,
      shellfish: shellfish ?? this.shellfish,
      soy: soy ?? this.soy,
      celery: celery ?? this.celery,
      mustard: mustard ?? this.mustard,
      sesame: sesame ?? this.sesame,
      sulfites: sulfites ?? this.sulfites,
      lupin: lupin ?? this.lupin,
      general: general ?? this.general,
    );
  }

  @override
  AllergenColors lerp(AllergenColors? other, double t) {
    if (other is! AllergenColors) return this;
    return AllergenColors(
      gluten: Color.lerp(gluten, other.gluten, t)!,
      dairy: Color.lerp(dairy, other.dairy, t)!,
      eggs: Color.lerp(eggs, other.eggs, t)!,
      nuts: Color.lerp(nuts, other.nuts, t)!,
      fish: Color.lerp(fish, other.fish, t)!,
      shellfish: Color.lerp(shellfish, other.shellfish, t)!,
      soy: Color.lerp(soy, other.soy, t)!,
      celery: Color.lerp(celery, other.celery, t)!,
      mustard: Color.lerp(mustard, other.mustard, t)!,
      sesame: Color.lerp(sesame, other.sesame, t)!,
      sulfites: Color.lerp(sulfites, other.sulfites, t)!,
      lupin: Color.lerp(lupin, other.lupin, t)!,
      general: Color.lerp(general, other.general, t)!,
    );
  }
}

class ProductCardColors extends ThemeExtension<ProductCardColors> {
  final Color successBackground;
  final Color successBorder;
  final Color successText;
  
  final Color warningBackground;
  final Color warningBorder;
  final Color warningText;
  
  final Color errorBackground;
  final Color errorBorder;
  final Color errorText;
  
  final Color infoBackground;
  final Color infoBorder;
  final Color infoText;

  const ProductCardColors({
    required this.successBackground,
    required this.successBorder,
    required this.successText,
    required this.warningBackground,
    required this.warningBorder,
    required this.warningText,
    required this.errorBackground,
    required this.errorBorder,
    required this.errorText,
    required this.infoBackground,
    required this.infoBorder,
    required this.infoText,
  });

  static const ProductCardColors light = ProductCardColors(
    successBackground: Color(0xFFe8f5e8),
    successBorder: Color(0xFF4caf50),
    successText: Color(0xFF2e7d32),
  
    warningBackground: Color(0xFFfff8e1),
    warningBorder: Color(0xFFffb300),
    warningText: Color(0xFFe65100),
    
    errorBackground: Color(0xFFffebee),
    errorBorder: Color(0xFFf44336),
    errorText: Color(0xFFc62828),
    
    infoBackground: Color(0xFFe3f2fd),
    infoBorder: Color(0xFF2196f3),
    infoText: Color(0xFF1565c0),
  );

  static const ProductCardColors dark = ProductCardColors(
    successBackground: Color(0xFF1b5e20),
    successBorder: Color(0xFF66bb6a),
    successText: Color(0xFF81c784),
    
    warningBackground: Color(0xFFe65100),
    warningBorder: Color(0xFFffb74d),
    warningText: Color(0xFFffcc02),
    
    errorBackground: Color(0xFFb71c1c),
    errorBorder: Color(0xFFef5350),
    errorText: Color(0xFFe57373),
    
    infoBackground: Color(0xFF0d47a1),
    infoBorder: Color(0xFF42a5f5),
    infoText: Color(0xFF64b5f6),
  );

  @override
  ProductCardColors copyWith({
    Color? successBackground,
    Color? successBorder,
    Color? successText,
    Color? warningBackground,
    Color? warningBorder,
    Color? warningText,
    Color? errorBackground,
    Color? errorBorder,
    Color? errorText,
    Color? infoBackground,
    Color? infoBorder,
    Color? infoText,
  }) {
    return ProductCardColors(
      successBackground: successBackground ?? this.successBackground,
      successBorder: successBorder ?? this.successBorder,
      successText: successText ?? this.successText,
      warningBackground: warningBackground ?? this.warningBackground,
      warningBorder: warningBorder ?? this.warningBorder,
      warningText: warningText ?? this.warningText,
      errorBackground: errorBackground ?? this.errorBackground,
      errorBorder: errorBorder ?? this.errorBorder,
      errorText: errorText ?? this.errorText,
      infoBackground: infoBackground ?? this.infoBackground,
      infoBorder: infoBorder ?? this.infoBorder,
      infoText: infoText ?? this.infoText,
    );
  }

  @override
  ProductCardColors lerp(ProductCardColors? other, double t) {
    if (other is! ProductCardColors) return this;
    return ProductCardColors(
      successBackground: Color.lerp(successBackground, other.successBackground, t)!,
      successBorder: Color.lerp(successBorder, other.successBorder, t)!,
      successText: Color.lerp(successText, other.successText, t)!,
      warningBackground: Color.lerp(warningBackground, other.warningBackground, t)!,
      warningBorder: Color.lerp(warningBorder, other.warningBorder, t)!,
      warningText: Color.lerp(warningText, other.warningText, t)!,
      errorBackground: Color.lerp(errorBackground, other.errorBackground, t)!,
      errorBorder: Color.lerp(errorBorder, other.errorBorder, t)!,
      errorText: Color.lerp(errorText, other.errorText, t)!,
      infoBackground: Color.lerp(infoBackground, other.infoBackground, t)!,
      infoBorder: Color.lerp(infoBorder, other.infoBorder, t)!,
      infoText: Color.lerp(infoText, other.infoText, t)!,
    );
  }
}

extension ThemeExtensionsX on ThemeData {
  FoodScoreColors get foodScoreColors => extension<FoodScoreColors>() ?? FoodScoreColors.light;
  AdditiveColors get additiveColors => extension<AdditiveColors>() ?? AdditiveColors.light;
  AllergenColors get allergenColors => extension<AllergenColors>() ?? AllergenColors.light;
  ProductCardColors get productCardColors => extension<ProductCardColors>() ?? ProductCardColors.light;
}

extension ColorExtensions on Color {
  Color get contrastingTextColor {
    final luminance = computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  Color withOpacity(double opacity) {
    return withValues(alpha: opacity);
  }

  Color get lighter {
    return Color.lerp(this, Colors.white, 0.3) ?? this;
  }

  Color get darker {
    return Color.lerp(this, Colors.black, 0.3) ?? this;
  }
  
  bool get isLight {
    return computeLuminance() > 0.5;
  }

  bool get isDark {
    return computeLuminance() <= 0.5;
  }
}
