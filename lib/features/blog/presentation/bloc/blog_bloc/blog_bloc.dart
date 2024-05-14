import 'dart:io';

import 'package:clean_blog/core/common/usecase/usecase_base.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:clean_blog/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:clean_blog/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase _uploadUseCase;
  final GetAllBlogsUseCase _getAllUseUseCase;
  BlogBloc(
      {required UploadBlogUseCase uploadUseCase,
      required GetAllBlogsUseCase getAllUseUseCase})
      : _uploadUseCase = uploadUseCase,
        _getAllUseUseCase = getAllUseUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((_, emit) => emit(BlogLoading()));
    on<BlogUploaded>(_onBlogUploaded);
    on<BlogGetAllBlogs>(_onGetAllBlogs);
  }

  void _onBlogUploaded(event, emit) async {
    final result = await _uploadUseCase.call(
      UploadBlogParams(
          userId: event.userId,
          title: event.title,
          content: event.content,
          image: event.image,
          topics: event.topics),
    );
    result.fold(
      (failure) => emit(BlogUploadFailure(failure.message)),
      (_) => emit(BloguploadSuccess()),
    );
  }

  void _onGetAllBlogs(event, emit) async {
    final result = await _getAllUseUseCase(NoParams());
    result.fold(
      (failure) => emit(BlogGetAllBlogsFailure(failure.message)),
      (blogs) => emit(BlogGetAllSuccess(blogs)),
    );
  }
}
