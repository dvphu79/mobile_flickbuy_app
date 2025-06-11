import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart'; // Add this if you want fromJson/toJson

@freezed
class Product with _$Product {
  const factory Product({
    @JsonKey(name: '\$id') required String id,
    required String name,
    required double price,
    @Default('') String imageUrl,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
