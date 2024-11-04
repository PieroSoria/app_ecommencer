class UserEntity {
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String password;
  final String photoUrl;
  // final String token;
  final String fcmToken;

  UserEntity(
      {required this.id,
      required this.name,
      required this.lastname,
      required this.email,
      required this.password,
      required this.photoUrl,
      // required this.token,
      required this.fcmToken});
}
