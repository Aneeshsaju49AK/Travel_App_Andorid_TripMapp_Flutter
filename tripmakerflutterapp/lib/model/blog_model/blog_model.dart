import 'package:hive/hive.dart';
part 'blog_model.g.dart';

@HiveType(typeId: 5)
class BlogModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? content;
  @HiveField(3)
  List<String>? images;

  BlogModel({
    this.id,
    required this.name,
    required this.content,
    this.images,
  });
}
