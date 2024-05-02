import 'package:clean_blog/core/theme/color_pallete.dart';
import 'package:clean_blog/core/utils/calculate_read_time/calculate_read_time.dart';
import 'package:clean_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:clean_blog/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCardWidget extends StatelessWidget {
  const BlogCardWidget({super.key, required this.blog});
  final BlogEntity blog;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, BlogViewPage.route(blog)),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
            color: Pallete.gradient1, borderRadius: BorderRadius.circular(14)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  scrollDirection: Axis.horizontal,
                  children: blog.topics
                      .map((el) => Padding(
                          padding: const EdgeInsets.all(16.0)
                              .copyWith(right: 2, left: 0),
                          child: Chip(label: Text(el))))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  blog.title,
                  style: const TextStyle(fontSize: 30),
                )
              ],
            ),
            Text('${calcReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
