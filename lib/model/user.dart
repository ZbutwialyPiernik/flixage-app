import 'package:flixage/model/queryable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Queryable {
  User({
    String id,
    String name,
    String thumbnailUrl,
  }) : super(id, name, thumbnailUrl);

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [id, name, thumbnailUrl];
}
