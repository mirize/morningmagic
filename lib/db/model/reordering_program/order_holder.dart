import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/reordering_program/order_item.dart';

part 'order_holder.g.dart';

@HiveType(typeId: 201)
class OrderHolder extends HiveObject {

  OrderHolder(this.list);

  @HiveField(0)
  List<OrderItem> list;

  @override
  String toString() {
    return 'OrderHolder{list: $list}';
  }
}