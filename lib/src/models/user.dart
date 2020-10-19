import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String name, phone, email;
  @JsonKey(name: 'subs')
  bool subscription;
  User(this.name, this.phone, this.email, this.subscription);

  factory User.fromJson(Map<String, dynamic> user) => _$UserFromJson(user);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
