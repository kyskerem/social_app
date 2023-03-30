// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      description: json['description'] as String,
      datePublished: DateTime.parse(json['datePublished'] as String),
      postUrl: json['postUrl'] as String,
      publisherName: json['publisherName'] as String,
      publisherUid: json['publisherUid'] as String,
      publisherProfileImage: json['publisherProfileImage'] as String,
      likes: json['likes'] as List<dynamic>? ?? const [],
      postId: json['postId'] as String?,
      comments: json['comments'] as List<dynamic>? ?? const [],
    )..id = json['id'] as String;

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'likes': instance.likes,
      'postId': instance.postId,
      'id': instance.id,
      'comments': instance.comments,
      'description': instance.description,
      'datePublished': instance.datePublished.toIso8601String(),
      'postUrl': instance.postUrl,
      'publisherName': instance.publisherName,
      'publisherUid': instance.publisherUid,
      'publisherProfileImage': instance.publisherProfileImage,
    };
