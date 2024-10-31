import 'dart:convert';

import 'package:app_ecommencer/features/auth/domain/entities/user_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.name,
      required super.lastname,
      required super.email,
      required super.password,
      required super.photoUrl,
      required super.token,
      required super.fcmToken});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        photoUrl: json["photo_url"],
        token: json["token"],
        fcmToken: json["fcm_token"],
      );

  factory UserModel.fromEntity(UserEntity userEntity) => UserModel(
        id: userEntity.id,
        name: userEntity.name,
        lastname: userEntity.lastname,
        email: userEntity.email,
        password: userEntity.password,
        photoUrl: userEntity.photoUrl,
        token: userEntity.token,
        fcmToken: userEntity.fcmToken,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "password": password,
        "photo_url": photoUrl,
        "token": token,
        "fcm_token": fcmToken,
      };
}
