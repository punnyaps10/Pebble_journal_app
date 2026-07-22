import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  String? profileImagePath;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.profileImagePath,
  });
}
