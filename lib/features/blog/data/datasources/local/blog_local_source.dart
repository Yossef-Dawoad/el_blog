import 'package:clean_blog/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  Future<List<BlogModel>> getBlogsfromStorage();
  Future<void> saveBlogtoStorage(List<BlogModel> blogs);
  Future<void> deleteBlogfromStorage(BlogModel blog);
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  Future<void> deleteBlogfromStorage(BlogModel blog) {
    throw UnimplementedError();
  }

  @override
  Future<List<BlogModel>> getBlogsfromStorage() async {
    return box.read(
      () => box.keys.map((id) => BlogModel.fromMap(box.get(id))).toList(),
    );
  }

  @override
  Future<void> saveBlogtoStorage(List<BlogModel> blogs) async {
    if (blogs.isEmpty) return;
    box.clear();
    box.write(() {
      box.putAll(
        Map.fromEntries(blogs.map((blog) => MapEntry(blog.id, blog.toMap()))),
      );
    });
  }
}
