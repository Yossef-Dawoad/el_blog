import 'package:clean_blog/core/common/blocs/localization/localization_bloc.dart';
import 'package:clean_blog/core/common/widgets/language_bottom_sheet.dart';
import 'package:clean_blog/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(8.0),
                    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20))),
                onPressed: () => showLanguagesSwitcherBottomSheet(context),
                child: Row(
                  children: [
                    BlocBuilder<LocalizationBloc, LocalizationState>(
                      // listenWhen: (previous, current) => current is LocalizationChangeSuccess,
                      // listener: (context, state) =>
                      //     state is LocalizationChangeSuccess ? Navigator.pop(context) : null,
                      builder: (context, state) => ClipOval(
                        child: Image.asset(
                          state.selectedLanguage.imagePath,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Icon(Icons.arrow_drop_down),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
