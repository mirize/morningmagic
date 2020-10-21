import 'package:hive/hive.dart';

part 'order_item.g.dart';

@HiveType(typeId: 200)
class OrderItem extends HiveObject {

  OrderItem(this.position);

  @HiveField(0)
  int position;

  @override
  String toString() {
    return 'OrderItem{position: $position}';
  }
}