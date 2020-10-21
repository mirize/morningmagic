// Can be generated automatically
import 'package:hive/hive.dart';
import 'package:morningmagic/db/model/user/user.dart';

class UserAdapter extends TypeAdapter<User> {

  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User(reader.read());
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.name);
  }
}