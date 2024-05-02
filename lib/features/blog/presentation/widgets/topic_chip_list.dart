import 'package:clean_blog/core/theme/color_pallete.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required this.topics});
  final List<String> topics;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<String> selectedTopics = [];
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: widget.topics
          .map((el) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: () => _selectTopics(el),
                  child: Chip(
                      color: MaterialStatePropertyAll(
                        selectedTopics.contains(el) ? Pallete.gradient1 : null,
                      ),
                      label: Text(el)),
                ),
              ))
          .toList(),
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
}
