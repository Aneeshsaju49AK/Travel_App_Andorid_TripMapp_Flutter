import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';

const BLOG_DB_NAME = 'blog-database';

abstract class BlogDbFunctions {
  Future<List<BlogModel>> getBlogs();
  Future<void> insertBlog(BlogModel value);
  Future<void> deletePlaces(int? id);
}

class BlogDB implements BlogDbFunctions {
  BlogDB._internal();
  static BlogDB instance = BlogDB._internal();
  factory BlogDB() {
    return instance;
  }
  ValueNotifier<List<BlogModel>> blogsallNotifier = ValueNotifier([]);
  @override
  Future<void> deletePlaces(int? id) async {
    final blogDB = await Hive.openBox<BlogModel>(BLOG_DB_NAME);
    final blogIndex =
        blogDB.keys.toList().indexWhere((key) => blogDB.get(key)?.id == id);
    if (blogIndex != -1) {
      await blogDB.deleteAt(blogIndex);
    }
    await blogDB.close();
    reFreshUIBlogs();
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    final blogDB = await Hive.openBox<BlogModel>(BLOG_DB_NAME);
    return blogDB.values.toList();
  }

  @override
  Future<void> insertBlog(BlogModel value) async {
    final blogDB = await Hive.openBox<BlogModel>(BLOG_DB_NAME);
    await blogDB.add(value);

    getBlogs();
  }

  Future<void> reFreshUIBlogs() async {
    final allBlogs = await getBlogs();
    blogsallNotifier.value.clear();
    await Future.forEach(
      allBlogs,
      (BlogModel blog) {
        blogsallNotifier.value.add(blog);
      },
    );
    blogsallNotifier.notifyListeners();
  }
}
