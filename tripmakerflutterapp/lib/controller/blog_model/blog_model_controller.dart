import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tripmakerflutterapp/model/blog_model/blog_model.dart';

const BLOG_DB_NAME = 'blog-database';

abstract class BlogDbFunctions {
  Future<List<BlogModel>> getBlogs();
  Future<void> insertBlog(BlogModel value);
  Future<void> deletePlaces(int id);
}

class BlogDB implements BlogDbFunctions {
  BlogDB._internal();
  static BlogDB instance = BlogDB._internal();
  factory BlogDB() {
    return instance;
  }
  ValueNotifier<List<BlogModel>> blogsallNotifier = ValueNotifier([]);
  @override
  Future<void> deletePlaces(int id) async {
    final blogDB = await Hive.openBox<BlogModel>(BLOG_DB_NAME);
    await blogDB.delete(id);
    // TODO: implement deletePlaces
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    final blogDB = await Hive.openBox<BlogModel>(BLOG_DB_NAME);
    return blogDB.values.toList();
    // TODO: implement getPlaces
  }

  @override
  Future<void> insertBlog(BlogModel value) async {
    // TODO: implement insertPlaces
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
