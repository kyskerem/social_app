// ignore_for_file: public_member_api_docs, sort_constructors_first, strict_raw_type, lines_longer_than_80_chars
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_app/products/utility/base/base_id_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post extends Equatable
    with Id
    implements JsonConverter<DateTime, Timestamp> {
  final List? likes;
  final String? postId;
  @override
  String get id => postId ?? '';
  final List? comments;
  final String description;
  final DateTime datePublished;
  final String postUrl;
  final String publisherName;
  final String publisherUid;
  final String publisherProfileImage;

  Post({
    required this.description,
    required this.datePublished,
    required this.postUrl,
    required this.publisherName,
    required this.publisherUid,
    required this.publisherProfileImage,
    this.likes = const [],
    this.postId,
    this.comments = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toMap(Post instance) => _$PostToJson(instance);

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime object) => Timestamp.fromDate(object);

  @override
  List<Object?> get props {
    return [
      likes,
      postId,
      comments,
      description,
      datePublished,
      postUrl,
      publisherName,
      publisherUid,
      publisherProfileImage,
    ];
  }

  Post copyWith({
    List? likes,
    String? postId,
    List? comments,
    String? description,
    DateTime? datePublished,
    String? postUrl,
    String? publisherName,
    String? publisherUid,
    String? publisherProfileImage,
  }) {
    return Post(
      likes: likes ?? this.likes,
      postId: postId ?? this.postId,
      comments: comments ?? this.comments,
      description: description ?? this.description,
      datePublished: datePublished ?? this.datePublished,
      postUrl: postUrl ?? this.postUrl,
      publisherName: publisherName ?? this.publisherName,
      publisherUid: publisherUid ?? this.publisherUid,
      publisherProfileImage:
          publisherProfileImage ?? this.publisherProfileImage,
    );
  }
}
