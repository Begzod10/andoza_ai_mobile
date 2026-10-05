import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';
import '../../providers/locale_provider.dart';

/// Human-readable name for [locale], shown both in the language picker and
/// as the trailing value on the Profile "Til/Язык/Language" row.
String languageDisplayName(Locale locale) => switch (locale.languageCode) {
      'ru' => 'Русский',
      'en' => 'English',
      _ => "O'zbekcha",
    };

/// Small flag emoji shown next to [languageDisplayName] — a quick visual
/// cue, not a claim about nationality (Russian/English are each spoken well
/// beyond the flag's own country).
String languageFlagEmoji(Locale locale) => switch (locale.languageCode) {
      'ru' => '🇷🇺',
      'en' => '🇬🇧',
      _ => '🇺🇿',
    };

/// Opens the language-picker bottom sheet and updates [localeProvider] when
/// the user picks a different language.
Future<void> showLanguagePickerSheet(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const _LanguagePickerSheet(),
  );
}

class _LanguagePickerSheet extends ConsumerWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(localeProvider);
    return Container(
      padding: const EdgeInsets.fromLTRB(
        DesignTokens.screenPaddingHorizontal,
        DesignTokens.spacingMd,
        DesignTokens.screenPaddingHorizontal,
        DesignTokens.spacingXl,
      ),
      decoration: const BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radiusSheet),
          topRight: Radius.circular(DesignTokens.radiusSheet),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44,
              height: 5,
              margin: const EdgeInsets.only(bottom: DesignTokens.spacingLg),
              decoration: BoxDecoration(
                color: DesignTokens.borderGray,
                borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
              ),
            ),
          ),
          for (final locale in supportedAppLocales)
            _LanguageOption(
              locale: locale,
              selected: locale.languageCode == current.languageCode,
              onTap: () {
                ref.read(localeProvider.notifier).setLocale(locale);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.locale,
    required this.selected,
    required this.onTap,
  });

  final Locale locale;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacingSm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spacingMd,
            vertical: DesignTokens.spacingMd,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected
                  ? DesignTokens.primaryBlue
                  : DesignTokens.borderGray,
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            color: selected ? DesignTokens.borderGrayAlt : DesignTokens.white,
          ),
          child: Row(
            children: [
              Text(
                languageFlagEmoji(locale),
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              Expanded(
                child: Text(
                  languageDisplayName(locale),
                  style: DesignTokens.subtitle2.copyWith(
                    color: selected
                        ? DesignTokens.primaryBlue
                        : DesignTokens.textDark,
                  ),
                ),
              ),
              if (selected)
                const Icon(Icons.check_circle, color: DesignTokens.primaryBlue),
            ],
          ),
        ),
      ),
    );
  }
}
