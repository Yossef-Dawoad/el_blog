part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BloguploadSuccess extends BlogState {}

final class BlogGetAllSuccess extends BlogState {
  final List<BlogEntity> blogs;
  BlogGetAllSuccess(this.blogs);
}

final class BlogUploadFailure extends BlogState {
  final String error;
  BlogUploadFailure(this.error);
}

final class BlogGetAllBlogsFailure extends BlogState {
  final String message;
  BlogGetAllBlogsFailure(this.message);
}
