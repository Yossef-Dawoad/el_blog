import 'package:clean_blog/core/theme/color_pallete.dart';
import 'package:clean_blog/core/utils/calculate_read_time/calculate_read_time.dart';
import 'package:clean_blog/core/utils/formatters/date_formatter.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BlogViewPage extends StatelessWidget {
  static route(BlogEntity blog) => MaterialPageRoute(
        builder: (context) => BlogViewPage(blog: blog),
      );

  final BlogEntity blog;
  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                    borderRadius: BorderRadius.circular(14), child: Image.network(blog.imageUrl)),
                const SizedBox(height: 12),
                Text(
                  'By ${blog.author}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calcReadingTime(blog.content)} min',
                  style: const TextStyle(color: Pallete.greyColor, fontSize: 16),
                ),
                const SizedBox(height: 16),
                MarkdownBody(data: blog.content)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
