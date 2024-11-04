import 'dart:convert';

import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

const key = "Password";

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.name,
      required super.lastname,
      required super.email,
      required super.password,
      required super.photoUrl,
      // required super.token,
      required super.fcmToken});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        photoUrl: json["photo_url"],
        // token: json["token"],
        fcmToken: json["fcm_token"],
      );

  factory UserModel.fromEntity(UserEntity userEntity) => UserModel(
        id: userEntity.id,
        name: userEntity.name,
        lastname: userEntity.lastname,
        email: userEntity.email,
        password: userEntity.password,
        photoUrl: userEntity.photoUrl,
        // token: userEntity.token,
        fcmToken: userEntity.fcmToken,
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "password": hashPassword(password),
        "photo_url": photoUrl,
        // "token": generateToken(email),
        "fcm_token": fcmToken,
      };

  static String generateToken(String email) {
    final token = JWT({
      "email": email,
    });
    return token.sign(SecretKey(key), expiresIn: const Duration(days: 1));
  }

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
