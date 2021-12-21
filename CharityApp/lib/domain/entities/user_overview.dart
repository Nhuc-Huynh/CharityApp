import 'package:charityapp/domain/entities/base_user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_overview.g.dart';

@CopyWith()
@JsonSerializable()
class UserOverview extends BaseUser {
  Uri? avatarUri;
  UserOverview({
    required name,
    required this.avatarUri,
    String? id,
  }) : super(name: name, id: id);

  // factory UserOverview.fromJson(Map<String, dynamic> json) => _$UserOverviewFromJson(json);
  // Map<String, dynamic> toJson() => _$UserOverviewToJson(this);

  factory UserOverview.fromJson(Map<String, dynamic> json) => UserOverview(
        name: json['name'],
        avatarUri: json['avatarUri'] == null
            ? null
            : Uri.parse(json['avatarUri'] as String),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'avatarUri': this.avatarUri?.toString(),
      };
}
