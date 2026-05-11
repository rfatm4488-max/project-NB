import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. See `example/lib/main.dart` for examples.
class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'مفكرتي'**
  String get appTitle => 'مفكرتي';

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home => 'الرئيسية';

  /// No description provided for @addEntry.
  ///
  /// In ar, this message translates to:
  /// **'إضافة مدخل'**
  String get addEntry => 'إضافة مدخل';

  /// No description provided for @details.
  ///
  /// In ar, this message translates to:
  /// **'التفاصيل'**
  String get details => 'التفاصيل';

  /// No description provided for @stats.
  ///
  /// In ar, this message translates to:
  /// **'الإحصائيات'**
  String get stats => 'الإحصائيات';

  /// No description provided for @categories.
  ///
  /// In ar, this message translates to:
  /// **'التصنيفات'**
  String get categories => 'التصنيفات';

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings => 'الإعدادات';

  /// No description provided for @title.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get title => 'العنوان';

  /// No description provided for @content.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى'**
  String get content => 'المحتوى';

  /// No description provided for @mood.
  ///
  /// In ar, this message translates to:
  /// **'الحالة المزاجية'**
  String get mood => 'الحالة المزاجية';

  /// No description provided for @category.
  ///
  /// In ar, this message translates to:
  /// **'التصنيف'**
  String get category => 'التصنيف';

  /// No description provided for @date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get date => 'التاريخ';

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save => 'حفظ';

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel => 'إلغاء';

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete => 'حذف';

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit => 'تعديل';

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search => 'بحث';

  /// No description provided for @filter.
  ///
  /// In ar, this message translates to:
  /// **'تصفية'**
  String get filter => 'تصفية';

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language => 'اللغة';

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الليلي'**
  String get darkMode => 'الوضع الليلي';

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic => 'العربية';

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get english => 'English';

  /// No description provided for @confirmDelete.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف هذا المدخل؟'**
  String get confirmDelete => 'هل أنت متأكد من حذف هذا المدخل؟';

  /// No description provided for @noEntries.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مدخلات'**
  String get noEntries => 'لا توجد مدخلات';

  /// No description provided for @moodHappy.
  ///
  /// In ar, this message translates to:
  /// **'سعيد'**
  String get moodHappy => 'سعيد';

  /// No description provided for @moodSad.
  ///
  /// In ar, this message translates to:
  /// **'حزين'**
  String get moodSad => 'حزين';

  /// No description provided for @moodAngry.
  ///
  /// In ar, this message translates to:
  /// **'غاضب'**
  String get moodAngry => 'غاضب';

  /// No description provided for @moodNeutral.
  ///
  /// In ar, this message translates to:
  /// **'محايد'**
  String get moodNeutral => 'محايد';

  /// No description provided for @moodExcited.
  ///
  /// In ar, this message translates to:
  /// **'مثير'**
  String get moodExcited => 'مثير';

  /// No description provided for @chooseMood.
  String get chooseMood => 'اختيار المزاج';

  /// No description provided for @editEntry.
  String get editEntry => 'تعديل الملاحظة';

  /// No description provided for @newEntry.
  String get newEntry => 'ملاحظة جديدة';

  /// No description provided for @saveChanges.
  String get saveChanges => 'حفظ التغيير';

  /// No description provided for @addNote.
  String get addNote => 'إضافة الملاحظة';

  /// No description provided for @entryTitle.
  String get entryTitle => 'أدخل العنوان';

  /// No description provided for @entryContent.
  String get entryContent => 'أدخل المحتوى';

  /// No description provided for @selectCategory.
  String get selectCategory => 'اختر التصنيف';

  /// No description provided for @categoryDaily.
  String get categoryDaily => 'يومي';

  /// No description provided for @categoryWork.
  String get categoryWork => 'عملي';

  /// No description provided for @categoryIdeas.
  String get categoryIdeas => 'أفكار';

  /// No description provided for @categoryMemories.
  String get categoryMemories => 'ذكريات';

  /// No description provided for @deleteEntryTitle.
  String get deleteEntryTitle => 'حذف الملاحظة';

  /// No description provided for @deleteEntryConfirm.
  String get deleteEntryConfirm => 'هل أنت متأكد أنك تريد حذف هذه الملاحظة؟';

  /// No description provided for @enterTitle.
  String get enterTitle => 'الرجاء إدخال العنوان';

  /// No description provided for @enterContent.
  String get enterContent => 'الرجاء إدخال المحتوى';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
