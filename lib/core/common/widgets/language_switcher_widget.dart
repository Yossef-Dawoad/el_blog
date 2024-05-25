import 'package:clean_blog/generated/l10n.dart';
import 'package:flutter/material.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({
    super.key,
    required this.l10n,
  });

  final S l10n;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Flexible(child: Text(l10n.changeLanguage)),
          SizedBox(
            width: 100,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: OutlinedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(Icons.arrow_drop_down),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
