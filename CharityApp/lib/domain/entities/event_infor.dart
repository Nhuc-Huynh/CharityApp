import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_infor.g.dart';

@CopyWith()
@JsonSerializable()
class EventInfor extends EventOverview {
  String? description;
  final DateTime? timeStart;
  LatLng? locationGeo;
  String? locationText;

  EventInfor({
    required String name,
    required String creatorId,
    String? avatarUri,
    String? backgroundUri,
    this.description,
    this.timeStart,
    int numberMember = 0,
    int numberPost = 0,
    List<TagEvent> tags = const [],
    String? id,
    DateTime? timeCreate,
    this.locationGeo,
    this.locationText,
  }) : super(
          name: name,
          creatorId: creatorId,
          avatarUri: avatarUri,
          backgroundUri: backgroundUri,
          id: id,
          tags: tags,
          timeCreate: timeCreate,
          numberMember: numberMember,
          numberPost: numberPost,
        );

  // factory EventInfor.fromJson(Map<String, dynamic> json) => _$EventInforFromJson(json);
  // Map<String, dynamic> toJson() => _$EventInforToJson(this);

  factory EventInfor.fromJson(Map<String, dynamic> json) => EventInfor(
        name: json['name'] as String,
        creatorId: json['creatorId'] as String,
        avatarUri: json['avatarUri'] as String?,
        backgroundUri: json['backgroundUri'] as String?,
        description: json['description'] as String?,
        timeStart: json['timeStart'] == null
            ? null
            : (json['timeStart'] as Timestamp).toDate(),
        timeCreate: json['timeCreate'] == null
            ? null
            : (json['timeCreate'] as Timestamp).toDate(),
        locationText: json['location'] as String?,
        locationGeo: json['geometry'] is List<dynamic>
            ? LatLng((json['geometry'] as List<dynamic>)[0],
                (json['geometry'] as List<dynamic>)[1])
            : null,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'creatorId': this.creatorId,
        'avatarUri': this.avatarUri,
        'backgroundUri': this.backgroundUri,
        'description': this.description,
        'timeStart':
            this.timeStart == null ? null : Timestamp.fromDate(this.timeStart!),
        // 'numberMember': this.numberMember,
        // 'numberPost': this.numberPost,
        'tags': this.tags.map((tag) => tag.id!).toList(),
        'timeCreate': this.timeCreate == null
            ? null
            : Timestamp.fromDate(this.timeCreate!),
        'location': this.locationText,
        'geometry': this.locationGeo == null
            ? null
            : [this.locationGeo!.latitude, this.locationGeo!.longitude],
      };
}
