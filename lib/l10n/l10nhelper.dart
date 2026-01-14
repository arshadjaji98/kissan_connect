import 'package:flutter/material.dart';
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
