import 'package:food_app/domain/entities/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_query_state.freezed.dart';

@freezed
sealed class ProductQueryState with _$ProductQueryState {
  const factory ProductQueryState.initial() = Initial;
  const factory ProductQueryState.loading() = Loading;
  const factory ProductQueryState.success(ProductEntity product) = Success;
  const factory ProductQueryState.error(String message) = Error;
}
