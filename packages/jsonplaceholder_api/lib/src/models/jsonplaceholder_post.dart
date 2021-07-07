import 'package:json_annotation/json_annotation.dart';

part 'jsonplaceholder_post.g.dart';

@JsonSerializable(createToJson: false)
class JsonPlaceholderPost {
  @JsonValue('id')
  final int id;
  @JsonValue('title')
  final String title;
  @JsonValue('body')
  final String body;

  JsonPlaceholderPost({
    required this.id,
    required this.title,
    required this.body,
  });

  // Generated methods
  factory JsonPlaceholderPost.fromJson(Map<String, dynamic> json) => _$JsonPlaceholderPostFromJson(json);
}
