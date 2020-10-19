import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  String city, street, country;

  Address(this.city, this.street, this.country);
  factory Address.fromJson(Map<String, dynamic> address) =>
      _$AddressFromJson(address);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
