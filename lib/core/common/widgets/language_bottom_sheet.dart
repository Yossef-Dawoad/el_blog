import 'package:clean_blog/core/common/blocs/localization/localization_bloc.dart';
import 'package:clean_blog/core/common/entities/languages.dart';
import 'package:clean_blog/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showLanguagesSwitcherBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    shape: const ContinuousRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(14.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).chooseLanguage,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12.0),
            BlocBuilder<LocalizationBloc, LocalizationState>(
              buildWhen: (prev, curr) => curr is LocalizationChangeSuccess,
              builder: (context, state) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final selectedLanguage = LanguagesEnum.values[index];
                      final isSelected = selectedLanguage == state.selectedLanguage;
                      return ListTile(
                        onTap: () {
                          context
                              .read<LocalizationBloc>()
                              .add(LocalizationChanged(selectedLanguage: selectedLanguage));
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((_) => Navigator.pop(context));
                        },
                        title: Text(selectedLanguage.name),
                        leading: ClipOval(
                          child: Image.asset(
                            selectedLanguage.imagePath,
                            width: 32,
                            height: 32,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(
                                Icons.check_circle_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                        shape: isSelected
                            ? ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                ),
                              )
                            : null,
                        tileColor:
                            isSelected ? Theme.of(context).primaryColor.withOpacity(0.2) : null,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 12.0),
                    itemCount: LanguagesEnum.values.length,
                  ),
                );
              },
            )
          ],
        ),
      ),
    ),
  );
}
