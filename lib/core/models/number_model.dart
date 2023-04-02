import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:social_app/products/utility/base/base_id_model.dart';

part 'number_model.g.dart';

@JsonSerializable()
class Version extends Equatable with Id {
  final String number;

  Version({
    required this.number,
  });
  @override
  String? get id => '';

  factory Version.fromJson(Map<String, dynamic> json) =>
      _$VersionFromJson(json);

  Map<String, dynamic> toJson(Version instance) => _$VersionToJson(instance);

  factory Version.fromMap(Map<String, dynamic> map) {
    return Version(number: map['number'] as String);
  }

  @override
  List<Object?> get props => [number];
}
