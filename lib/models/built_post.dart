library built_post;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'built_post.g.dart';

abstract class BuiltPost implements Built<BuiltPost, BuiltPostBuilder> {
  @nullable
  int get id;
  String get title;
  String get body;

  BuiltPost._();

  factory BuiltPost([updates(BuiltPostBuilder b)]) = _$BuiltPost;
  static Serializer<BuiltPost> get serializer => _$builtPostSerializer;
}
