import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:food_app/domain/entities/product_entity.dart';

part 'product_search_state.freezed.dart';

@freezed
sealed class ProductSearchState with _$ProductSearchState {
  const factory ProductSearchState.initial() = Initial;
  const factory ProductSearchState.loading() = Loading;
  const factory ProductSearchState.success(List<ProductEntity> products) = Success;
  const factory ProductSearchState.empty() = Empty;
  const factory ProductSearchState.error(String message) = Error;
}
