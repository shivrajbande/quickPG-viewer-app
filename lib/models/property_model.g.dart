// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      propertyID: json['propertyID'] as String,
      propertyInfo:
          PropertyInfo.fromJson(json['propertyInfo'] as Map<String, dynamic>),
      ownerInfo: json['ownerInfo'] == null
          ? null
          : OwnerInfo.fromJson(json['ownerInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'propertyID': instance.propertyID,
      'propertyInfo': instance.propertyInfo,
      'ownerInfo': instance.ownerInfo,
    };

PropertyInfo _$PropertyInfoFromJson(Map<String, dynamic> json) => PropertyInfo(
      propertyDetailsFilled: json['propertyDetailsFilled'] as bool,
      propertyVerified: json['propertyVerified'] as bool,
      basicDetails:
          BasicDetails.fromJson(json['basicDetails'] as Map<String, dynamic>),
      additionalDetails: AdditionalDetails.fromJson(
          json['additionalDetails'] as Map<String, dynamic>),
      propertyDescription: json['propertyDescription'] as String,
      facilities: json['facilities'] as List<dynamic>,
      propertyImagesList: json['propertyImagesList'] as List<dynamic>,
      sharingInfo: (json['sharingInfo'] as List<dynamic>)
          .map((e) => SharingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ownerProfileId: json["ownerProfileId"] as String,
    );

Map<String, dynamic> _$PropertyInfoToJson(PropertyInfo instance) =>
    <String, dynamic>{
      'propertyDetailsFilled': instance.propertyDetailsFilled,
      'propertyVerified': instance.propertyVerified,
      'basicDetails': instance.basicDetails,
      'additionalDetails': instance.additionalDetails,
      'propertyDescription': instance.propertyDescription,
      'sharingInfo': instance.sharingInfo,
      'facilities': instance.facilities,
      'propertyImagesList': instance.propertyImagesList,
      'ownerProfileId': instance.ownerProfileId,
    };

BasicDetails _$BasicDetailsFromJson(Map<String, dynamic> json) => BasicDetails(
      propertyAge: (json['propertyAge'] as num).toInt(),
      propertyFacing: json['propertyFacing'] as String,
      propertyName: json['propertyName'] as String,
      floorsCount: (json['floorsCount'] as num).toInt(),
      bathroomsCount: (json['bathroomsCount'] as num).toInt(),
      balconysCount: (json['balconysCount'] as num).toInt(),
      maxSharing: (json['maxSharing'] as num).toInt(),
    );

Map<String, dynamic> _$BasicDetailsToJson(BasicDetails instance) =>
    <String, dynamic>{
      'propertyAge': instance.propertyAge,
      'propertyFacing': instance.propertyFacing,
      'propertyName': instance.propertyName,
      'floorsCount': instance.floorsCount,
      'bathroomsCount': instance.bathroomsCount,
      'balconysCount': instance.balconysCount,
      'maxSharing': instance.maxSharing,
    };

PropertyCreatedTime _$PropertyCreatedTimeFromJson(Map<String, dynamic> json) =>
    PropertyCreatedTime(
      seconds: (json['seconds'] as num).toInt(),
      nanoseconds: (json['nanoseconds'] as num).toInt(),
    );

Map<String, dynamic> _$PropertyCreatedTimeToJson(
        PropertyCreatedTime instance) =>
    <String, dynamic>{
      'seconds': instance.seconds,
      'nanoseconds': instance.nanoseconds,
    };

AdditionalDetails _$AdditionalDetailsFromJson(Map<String, dynamic> json) =>
    AdditionalDetails(
      preferredTenant: json['preferredTenant'] as List<dynamic>,
      securityDeposit: json['securityDeposite'],
      commonArea: json['commonArea'] as List<dynamic>,
      nearByPlaces: json['nearByPlaces'] as List<dynamic>,
    );

Map<String, dynamic> _$AdditionalDetailsToJson(AdditionalDetails instance) =>
    <String, dynamic>{
      'preferredTenant': instance.preferredTenant,
      'securityDeposit': instance.securityDeposit,
      'commonArea': instance.commonArea,
      'nearByPlaces': instance.nearByPlaces,
    };

SharingModel _$SharingInfoFromJson(Map<String, dynamic> json) => SharingModel(
      name: (json.entries.first.key) as String,
      maxValue: json.entries.first.value as String,
      controller: json.entries.first.value,
      status: true,
    );

Map<String, dynamic> _$SharingInfoToJson(SharingModel instance) =>
    <String, dynamic>{
      'sharingType': instance.name,
      'sharingPrice': instance.maxValue,
    };
OwnerInfo _$OwnerInfoFromJson(Map<String, dynamic> json) => OwnerInfo(
      profilePhoto: json["photoURL"] as String,
      name: json['name'] as String,
      ownerId: json["uid"] as String,
      ownerChatId : json['chatId'] as String,
      email: json['email'] ??"text@gmail.com",
      phoneNumber: json['phoneNumber'] ??"1234567890",
    );

Map<String, dynamic> _$OwnerInfoToJson(OwnerInfo instance) => <String, dynamic>{
      'profilePhoto': instance.profilePhoto,
      'name': instance.name,
      'ownerId': instance.ownerId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
