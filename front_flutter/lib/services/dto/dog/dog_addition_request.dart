
import 'package:json_annotation/json_annotation.dart';

part 'dog_addition_request.g.dart';

@JsonSerializable()
class DogAdditionRequest {
  final String photoName;
  final String name;
  final int breedId;
  final String age;
  final String gender;
  final List<int> behaviorsIds;
  final String description;

  DogAdditionRequest(this.photoName, this.name, this.breedId, this.age,
      this.gender, this.behaviorsIds, this.description);


  factory DogAdditionRequest.fromJson(Map<String, dynamic> json) => _$DogAdditionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DogAdditionRequestToJson(this);

}