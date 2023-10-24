// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DogUpdateRequest _$DogUpdateRequestFromJson(Map<String, dynamic> json) =>
    DogUpdateRequest(
      json['dogId'] as int,
      json['photoName'] as String,
      json['name'] as String,
      json['breedId'] as int,
      json['age'] as String,
      json['gender'] as String,
      (json['behaviorsIds'] as List<dynamic>).map((e) => e as int).toList(),
      json['description'] as String,
    );

Map<String, dynamic> _$DogUpdateRequestToJson(DogUpdateRequest instance) =>
    <String, dynamic>{
      'dogId': instance.dogId,
      'photoName': instance.photoName,
      'name': instance.name,
      'breedId': instance.breedId,
      'age': instance.age,
      'gender': instance.gender,
      'behaviorsIds': instance.behaviorsIds,
      'description': instance.description,
    };
