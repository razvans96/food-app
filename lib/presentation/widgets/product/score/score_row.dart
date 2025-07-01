import 'package:flutter/material.dart';
import 'package:food_app/presentation/widgets/product/score/score_helper.dart';

enum ScoreType { nutriscore, ecoscore, nova }

class ScoreRow extends StatelessWidget {
  final ScoreType scoreType;
  final String? scoreValue;
  final String interpretationText;

  const ScoreRow({
    required this.scoreType,
    required this.scoreValue,
    required this.interpretationText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scoreData = ScoreHelper.getScoreData(context, scoreType, scoreValue);
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: scoreData.backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: scoreData.borderColor,
        ),
      ),
      child: Row(
        children: [
          _buildScoreIndicator(scoreData),
          const SizedBox(width: 12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getScoreTitle(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  interpretationText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scoreData.textColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreIndicator(ScoreData scoreData) {
    if (scoreValue == null || scoreValue!.isEmpty) {
      return _buildUnknownIndicator();
    }

    switch (scoreType) {
      case ScoreType.nutriscore:
        return _buildNutriscoreIndicator(scoreData);
      case ScoreType.ecoscore:
        return _buildEcoscoreIndicator(scoreData);
      case ScoreType.nova:
        return _buildNovaIndicator(scoreData);
    }
  }

  Widget _buildNutriscoreIndicator(ScoreData scoreData) {
    return Container(
      width: 40,
      height: 32,
      decoration: BoxDecoration(
        color: scoreData.indicatorColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: scoreData.indicatorBorderColor,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          scoreValue!.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: scoreData.indicatorTextColor,
          ),
        ),
      ),
    );
  }

  Widget _buildEcoscoreIndicator(ScoreData scoreData) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: scoreData.indicatorColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: scoreData.indicatorBorderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: scoreData.indicatorColor.withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          scoreValue!.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: scoreData.indicatorTextColor,
          ),
        ),
      ),
    );
  }

  Widget _buildNovaIndicator(ScoreData scoreData) {
    return SizedBox(
      width: 40,
      height: 32,
      child: Center(
        child: Text(
          scoreValue!,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: scoreData.indicatorColor,
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                blurRadius: 2,
                color: scoreData.indicatorColor.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnknownIndicator() {
    switch (scoreType) {
      case ScoreType.nutriscore:
        return Container(
          width: 40,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.grey[400]!,
              width: 1.5,
            ),
          ),
          child: const Center(
            child: Text(
              '?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        );
      
      case ScoreType.ecoscore:
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey[400]!,
              width: 2,
            ),
          ),
          child: const Center(
            child: Text(
              '?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        );
      
      case ScoreType.nova:
        return SizedBox(
          width: 40,
          height: 32,
          child: Center(
            child: Text(
              '?',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.grey[500],
              ),
            ),
          ),
        );
    }
  }

  String _getScoreTitle() {
    switch (scoreType) {
      case ScoreType.nutriscore:
        return 'NUTRISCORE';
      case ScoreType.ecoscore:
        return 'ECOSCORE';
      case ScoreType.nova:
        return 'NOVA GROUP';
    }
  }
}
