
import 'package:json_annotation/json_annotation.dart';

part 'dog_update_request.g.dart';

@JsonSerializable()
class DogUpdateRequest {
  final int dogId;
  final String photoName;
  final String name;
  final int breedId;
  final String age;
  final String gender;
  final List<int> behaviorsIds;
  final String description;

  DogUpdateRequest(this.dogId, this.photoName, this.name, this.breedId, this.age,
      this.gender, this.behaviorsIds, this.description);


  factory DogUpdateRequest.fromJson(Map<String, dynamic> json) => _$DogUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DogUpdateRequestToJson(this);

}