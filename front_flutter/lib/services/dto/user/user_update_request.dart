import 'package:json_annotation/json_annotation.dart';

part 'user_update_request.g.dart';

@JsonSerializable()
class UserUpdateRequest {
  final String firstName;
  final String lastName;
  final String gender;
  final String city;
  final String phone;


  UserUpdateRequest(
      this.firstName, this.lastName, this.gender, this.city, this.phone);

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);

}