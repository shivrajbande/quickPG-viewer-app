import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property_model.g.dart'; // Add this line

@JsonSerializable()
class Property {
  final String propertyID;
  final PropertyInfo propertyInfo;
   final OwnerInfo? ownerInfo;

  Property({
    required this.propertyID,
    required this.propertyInfo,
    required this.ownerInfo
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}

@JsonSerializable()
class PropertyInfo {
  final bool propertyDetailsFilled;
  final bool propertyVerified;
  final BasicDetails basicDetails;
  final AdditionalDetails additionalDetails;
  final String propertyDescription;
  final List<SharingModel> sharingInfo;
  final List facilities;
  final List propertyImagesList;
  final String ownerProfileId;

  PropertyInfo(
      {required this.propertyDetailsFilled,
      required this.propertyVerified,
      required this.basicDetails,
      required this.additionalDetails,
      required this.propertyDescription,
      required this.facilities,
      required this.propertyImagesList,
      required this.sharingInfo,
      required this.ownerProfileId});

  factory PropertyInfo.fromJson(Map<String, dynamic> json) =>
      _$PropertyInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyInfoToJson(this);
}

@JsonSerializable()
class BasicDetails {
  final int propertyAge;
  final String propertyFacing;
  final String propertyName;
  final int floorsCount;
  final int bathroomsCount;
  // final PropertyCreatedTime propertyCreatedTime;
  final int balconysCount;
  final int maxSharing;

  BasicDetails(
      {required this.propertyAge,
      required this.propertyFacing,
      required this.propertyName,
      required this.floorsCount,
      required this.bathroomsCount,
      // required this.propertyCreatedTime,
      required this.balconysCount,
      required this.maxSharing});

  factory BasicDetails.fromJson(Map<String, dynamic> json) =>
      _$BasicDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BasicDetailsToJson(this);
}

@JsonSerializable()
class PropertyCreatedTime {
  final int seconds;
  final int nanoseconds;

  PropertyCreatedTime({
    required this.seconds,
    required this.nanoseconds,
  });

  factory PropertyCreatedTime.fromJson(Map<String, dynamic> json) =>
      _$PropertyCreatedTimeFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyCreatedTimeToJson(this);
}

@JsonSerializable()
class AdditionalDetails {
  final List preferredTenant;
  final int securityDeposit;
  final List commonArea;
  final List nearByPlaces;

  AdditionalDetails({
    required this.preferredTenant,
    required this.securityDeposit,
    required this.commonArea,
    required this.nearByPlaces,
  });

  factory AdditionalDetails.fromJson(Map<String, dynamic> json) =>
      _$AdditionalDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalDetailsToJson(this);
}



@JsonSerializable()
class SharingModel {
  final String name;
  final String maxValue;
  final String controller;
  final bool status;

  SharingModel({ required this.name,required this.maxValue,required this.controller,required this.status});
  factory SharingModel.fromJson(Map<String, dynamic> json) =>
      _$SharingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SharingInfoToJson(this);
}

@JsonSerializable()
class OwnerInfo {
  final String profilePhoto;
  final String name;
  final String ownerId;
  final String ownerChatId;
  String?email;
  String?phoneNumber;

  

  OwnerInfo({
    required this.profilePhoto,
    required this.name,
    required this.ownerId,
    required this.ownerChatId,
    this.email,
    this.phoneNumber
    
  });

  factory OwnerInfo.fromJson(Map<String, dynamic> json) =>
      _$OwnerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerInfoToJson(this);
}

