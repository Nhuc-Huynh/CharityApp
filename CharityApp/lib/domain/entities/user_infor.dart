import 'package:charityapp/core/helper/conver_string_to_datetime.dart';
import 'package:charityapp/core/helper/uint8list_converter.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_infor.g.dart';

enum Genders {
  Male,
  Female,
  Undefined,
}

@JsonSerializable()
class UserInfor extends UserOverview {
  String? description;
  String? birthDayString;
  Genders gender;

  DateTime? get birthDay => StringToDatetime.Convert(birthDayString);// birthDayString != null ? DateFormat('dd/MM/yyyy').parse(birthDayString!) : null;

  UserInfor({required name, 
//<<<<<<< Updated upstream
      required avatarUri,
      required this.description,
      required this.birthDayString,
      required this.gender,
  }) : super(name: name, avatarUri: avatarUri);
// =======
//       //required avatar,
//       required this.description,
//       required this.birthDayString,
//       required this.gender,
//   }) : super(name: name);
// >>>>>>> Stashed changes

  factory UserInfor.fromJson(Map<String, dynamic> json) => _$UserInforFromJson(json);
  Map<String, dynamic> toJson() => _$UserInforToJson(this);
}