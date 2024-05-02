import 'package:clean_blog/core/common/widgets/loaders.dart';
import 'package:clean_blog/core/common/widgets/snackbars.dart';
import 'package:clean_blog/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:clean_blog/features/blog/presentation/pages/add_new_blog.dart';
import 'package:clean_blog/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, AddNewBlog.route()),
              icon: const Icon(Icons.add_circle_outline_sharp))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogGetAllBlogsFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) return const FullBodyLoadinIndicator();
          if (state is BlogGetAllSuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                // color  based on the image, maybe?
                return BlogCardWidget(blog: blog);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
