// GENERATED CODE - DO NOT MODIFY BY HAND

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `تسجيل الدخول`
  String get login {
    return Intl.message(
      'تسجيل الدخول',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `أدخل التفاصيل الخاصة بك لتسجيل الدخول`
  String get belowlogin {
    return Intl.message(
      'أدخل التفاصيل الخاصة بك لتسجيل الدخول',
      name: 'belowlogin',
      desc: '',
      args: [],
    );
  }

  /// `عنوان البريد الإلكتروني`
  String get enteremailorphone {
    return Intl.message(
      'عنوان البريد الإلكتروني',
      name: 'enteremailorphone',
      desc: '',
      args: [],
    );
  }

  /// `برجاء ادخال بريد الكتروني`
  String get erroremailorphone {
    return Intl.message(
      'برجاء ادخال بريد الكتروني',
      name: 'erroremailorphone',
      desc: '',
      args: [],
    );
  }

  /// `ادخل كلمة المرور الخاصة بك`
  String get enterpassword {
    return Intl.message(
      'ادخل كلمة المرور الخاصة بك',
      name: 'enterpassword',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور ضعيفة`
  String get errorpassword {
    return Intl.message(
      'كلمة المرور ضعيفة',
      name: 'errorpassword',
      desc: '',
      args: [],
    );
  }

  /// `هل نسيت كلمت المرور ؟`
  String get forgotpassword {
    return Intl.message(
      'هل نسيت كلمت المرور ؟',
      name: 'forgotpassword',
      desc: '',
      args: [],
    );
  }

  /// `ليس لديك حساب ؟`
  String get donthaveaccount {
    return Intl.message(
      'ليس لديك حساب ؟',
      name: 'donthaveaccount',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل حساب جديد`
  String get soRegister {
    return Intl.message(
      'تسجيل حساب جديد',
      name: 'soRegister',
      desc: '',
      args: [],
    );
  }

  /// `إنشــاء حسـاب`
  String get CreateAccount {
    return Intl.message(
      'إنشــاء حسـاب',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `أدخل التفاصيل الخاصة بك لتسجيل الدخول`
  String get enteryouraccountdetails {
    return Intl.message(
      'أدخل التفاصيل الخاصة بك لتسجيل الدخول',
      name: 'enteryouraccountdetails',
      desc: '',
      args: [],
    );
  }

  /// `ارسال`
  String get Send {
    return Intl.message(
      'ارسال',
      name: 'Send',
      desc: '',
      args: [],
    );
  }

  /// `الاسم بالكامل`
  String get fullname {
    return Intl.message(
      'الاسم بالكامل',
      name: 'fullname',
      desc: '',
      args: [],
    );
  }

  /// `برجاء ادخال اسم صحيح`
  String get errorName {
    return Intl.message(
      'برجاء ادخال اسم صحيح',
      name: 'errorName',
      desc: '',
      args: [],
    );
  }

  /// `البريد الالكتروني`
  String get email {
    return Intl.message(
      'البريد الالكتروني',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `برجاء ادخال بريد الإلكتروني صحيح`
  String get errorEmail {
    return Intl.message(
      'برجاء ادخال بريد الإلكتروني صحيح',
      name: 'errorEmail',
      desc: '',
      args: [],
    );
  }

  /// `رقم الهاتف`
  String get phone {
    return Intl.message(
      'رقم الهاتف',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `برجاء ادخال رقم موبايل صحيح`
  String get errorPhone {
    return Intl.message(
      'برجاء ادخال رقم موبايل صحيح',
      name: 'errorPhone',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور`
  String get password {
    return Intl.message(
      'كلمة المرور',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `إعادة كتابة كلمة المرور`
  String get repassword {
    return Intl.message(
      'إعادة كتابة كلمة المرور',
      name: 'repassword',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور غير متطابقة`
  String get errorRePassword {
    return Intl.message(
      'كلمة المرور غير متطابقة',
      name: 'errorRePassword',
      desc: '',
      args: [],
    );
  }

  /// `هل لديك حساب بالفعل ؟`
  String get haveAnAccount {
    return Intl.message(
      'هل لديك حساب بالفعل ؟',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `تغــير كلـمة الـمرور`
  String get changePassword {
    return Intl.message(
      'تغــير كلـمة الـمرور',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `الرجاء إدخال كلمة المرور الجديدة الخاصة بك`
  String get belowChangePassowrd {
    return Intl.message(
      'الرجاء إدخال كلمة المرور الجديدة الخاصة بك',
      name: 'belowChangePassowrd',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور الجديدة`
  String get newPassowrd {
    return Intl.message(
      'كلمة المرور الجديدة',
      name: 'newPassowrd',
      desc: '',
      args: [],
    );
  }

  /// `هل تذكرت كلمة المرور ؟`
  String get rememberedPassword {
    return Intl.message(
      'هل تذكرت كلمة المرور ؟',
      name: 'rememberedPassword',
      desc: '',
      args: [],
    );
  }

  /// ` برجاء ادخال البريد الالكتروني لارسال رمز التحقيق `
  String get enteremailorphoneOTP {
    return Intl.message(
      ' برجاء ادخال البريد الالكتروني لارسال رمز التحقيق ',
      name: 'enteremailorphoneOTP',
      desc: '',
      args: [],
    );
  }

  /// `رمز التحقيق`
  String get verificationcode {
    return Intl.message(
      'رمز التحقيق',
      name: 'verificationcode',
      desc: '',
      args: [],
    );
  }

  /// `لقد ارسلنا رمز التحقيق الخاص بك الي`
  String get belowVC {
    return Intl.message(
      'لقد ارسلنا رمز التحقيق الخاص بك الي',
      name: 'belowVC',
      desc: '',
      args: [],
    );
  }

  /// `تحقق`
  String get verify {
    return Intl.message(
      'تحقق',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `تغيير`
  String get change {
    return Intl.message(
      'تغيير',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `تم تعيين كلمة المرور بنجاح`
  String get ChangedPasswordSuccess {
    return Intl.message(
      'تم تعيين كلمة المرور بنجاح',
      name: 'ChangedPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `تم تعيين كلمة المرور الخاصة بك. الاستمرار في الصفحة الرئيسية`
  String get ChangedPasswordSuccess2 {
    return Intl.message(
      'تم تعيين كلمة المرور الخاصة بك. الاستمرار في الصفحة الرئيسية',
      name: 'ChangedPasswordSuccess2',
      desc: '',
      args: [],
    );
  }

  /// `مـوقعـك`
  String get location {
    return Intl.message(
      'مـوقعـك',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `الرجاء إدخال مدينتك لمساعدتنا في اقتراح المنازل القريبة منك`
  String get belowLocation {
    return Intl.message(
      'الرجاء إدخال مدينتك لمساعدتنا في اقتراح المنازل القريبة منك',
      name: 'belowLocation',
      desc: '',
      args: [],
    );
  }

  /// `مسكني بلس`
  String get masknyPlus {
    return Intl.message(
      'مسكني بلس',
      name: 'masknyPlus',
      desc: '',
      args: [],
    );
  }

  /// `مجموعة من الخدمات المميزة تقدم ضمن باقة خاصة للعملاء للاستفادة الكاملة من تطبيق مسكني`
  String get belowMasknyPlus {
    return Intl.message(
      'مجموعة من الخدمات المميزة تقدم ضمن باقة خاصة للعملاء للاستفادة الكاملة من تطبيق مسكني',
      name: 'belowMasknyPlus',
      desc: '',
      args: [],
    );
  }

  /// `اشتراك في الخدمة`
  String get Subscribe {
    return Intl.message(
      'اشتراك في الخدمة',
      name: 'Subscribe',
      desc: '',
      args: [],
    );
  }

  /// `أهلا بك`
  String get Welcome {
    return Intl.message(
      'أهلا بك',
      name: 'Welcome',
      desc: '',
      args: [],
    );
  }

  /// `أماكن الإقامة القريبة منك`
  String get NearestPlaces {
    return Intl.message(
      'أماكن الإقامة القريبة منك',
      name: 'NearestPlaces',
      desc: '',
      args: [],
    );
  }

  /// `مشاهدة الاكثر`
  String get SeeMore {
    return Intl.message(
      'مشاهدة الاكثر',
      name: 'SeeMore',
      desc: '',
      args: [],
    );
  }

  /// `الأماكن الموصى بها`
  String get suggestedPlaces {
    return Intl.message(
      'الأماكن الموصى بها',
      name: 'suggestedPlaces',
      desc: '',
      args: [],
    );
  }

  /// `وصــف المـنـزل`
  String get homeDesc {
    return Intl.message(
      'وصــف المـنـزل',
      name: 'homeDesc',
      desc: '',
      args: [],
    );
  }

  /// `الموقع والخدمات الماجورة`
  String get places {
    return Intl.message(
      'الموقع والخدمات الماجورة',
      name: 'places',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
