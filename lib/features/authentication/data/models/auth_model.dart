import 'package:hive/hive.dart';
part 'auth_model.g.dart';

@HiveType(typeId: 0)
class Auth extends HiveObject {
  @HiveField(0)
  late String token;
}
