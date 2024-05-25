import 'dart:io';

import 'package:clean_blog/core/common/blocs/app_user/app_user_bloc.dart';
import 'package:clean_blog/core/common/widgets/loaders.dart';
import 'package:clean_blog/core/common/widgets/snackbars.dart';
import 'package:clean_blog/core/theme/color_pallete.dart';
import 'package:clean_blog/core/utils/image_picker/pick_image.dart';
import 'package:clean_blog/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:clean_blog/features/blog/presentation/pages/blog_page.dart';
import 'package:clean_blog/features/blog/presentation/widgets/blog_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const AddNewBlog());
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _contentCtrl = TextEditingController();
  List<String> selectedTopics = [];
  File? image;
  final _formKey = GlobalKey<FormState>();

  void selectBlogImage() async {
    final selectedImage = await pickImage();
    if (selectedImage != null) setState(() => image = selectedImage);
  }

  @override
  void dispose() {
    super.dispose();
    _titleCtrl.dispose();
    _contentCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _uploadBlog,
            icon: const Icon(Icons.done_rounded),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listenWhen: (prev, curr) =>
            curr is BlogLoading || curr is BloguploadSuccess || curr is BlogUploadFailure,
        buildWhen: (prev, curr) =>
            curr is BlogLoading || curr is BloguploadSuccess || curr is BlogUploadFailure,
        listener: (context, state) {
          if (state is BlogUploadFailure) {
            showSnackBar(context, state.error);
          } else if (state is BloguploadSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) return const FullBodyLoadinIndicator();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: selectBlogImage,
                      child: (image != null)
                          ? SizedBox(
                              width: double.infinity,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(image!, fit: BoxFit.cover),
                              ),
                            )
                          : DottedBorder(
                              color: Pallete.borderColor,
                              dashPattern: const [10, 4],
                              radius: const Radius.circular(16),
                              borderType: BorderType.RRect,
                              child: const SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Icon(Icons.folder_open_rounded, size: 40),
                                    SizedBox(height: 15),
                                    Text('Select your image', style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    ListView(
                      scrollDirection: Axis.horizontal,
                      children: ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map((el) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () => _selectTopics(el),
                                  child: Chip(
                                      color: WidgetStatePropertyAll(
                                        selectedTopics.contains(el) ? Pallete.gradient1 : null,
                                      ),
                                      label: Text(el)),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    BlogTextField(controller: _titleCtrl, hintText: 'Blog Tilte'),
                    const SizedBox(height: 20),
                    BlogTextField(controller: _contentCtrl, hintText: 'Blog Content'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _selectTopics(String ele) {
    if (selectedTopics.contains(ele)) {
      selectedTopics.remove(ele);
    } else {
      selectedTopics.add(ele);
    }
    setState(() {});
  }

  void _uploadBlog() {
    if (_formKey.currentState!.validate() && selectedTopics.isNotEmpty && image != null) {
      final userId =
          (context.read<AuthenticatedUserBloc>().state as AuthenticatedUserLoggedInSuccess).user.id;
      context.read<BlogBloc>().add(BlogUploaded(
          userId: userId,
          title: _titleCtrl.text.trim(),
          content: _contentCtrl.text.trim(),
          image: image!,
          topics: selectedTopics));
    }
  }
}
