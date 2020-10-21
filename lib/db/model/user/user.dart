import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class User extends HiveObject {

  User(this.name);

  @HiveField(0)
  String name;

  @override
  String toString() {
    return 'User{name: $name}';
  }


}