import 'package:isar/isar.dart';

part 'cart_item.g.dart';

@collection
class CartItem {
  Id id = Isar.autoIncrement; // Auto incrementing ID

  @Index(
    unique: true,
    replace: true,
  ) // Ensures productId is unique, and replaces on conflict if ids are different
  late String productId;

  late int quantity;
}
