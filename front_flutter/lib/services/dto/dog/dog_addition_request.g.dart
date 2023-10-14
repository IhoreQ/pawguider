// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_addition_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DogAdditionRequest _$DogAdditionRequestFromJson(Map<String, dynamic> json) =>
    DogAdditionRequest(
      json['photoName'] as String,
      json['name'] as String,
      json['breedId'] as int,
      json['age'] as String,
      json['gender'] as String,
      (json['behaviorsIds'] as List<dynamic>).map((e) => e as int).toList(),
      json['description'] as String,
    );

Map<String, dynamic> _$DogAdditionRequestToJson(DogAdditionRequest instance) =>
    <String, dynamic>{
      'photoName': instance.photoName,
      'name': instance.name,
      'breedId': instance.breedId,
      'age': instance.age,
      'gender': instance.gender,
      'behaviorsIds': instance.behaviorsIds,
      'description': instance.description,
    };
