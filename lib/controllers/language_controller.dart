import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';

class LanguageController extends GetxController {
  final _currentLanguage = 'en'.obs;

  String get currentLanguage => _currentLanguage.value;
  Locale get currentLocale => _currentLanguage.value == 'fa'
      ? const Locale('fa', 'IR')
      : const Locale('en', 'US');

  @override
  void onInit() {
    super.onInit();
    // Set initial language
    _currentLanguage.value = 'en';
  }

  void changeLanguage(String languageCode) {
    if (languageCode != _currentLanguage.value) {
      _currentLanguage.value = languageCode;
      Get.updateLocale(currentLocale);
    }
  }

  void toggleLanguage() {
    final newLanguage = _currentLanguage.value == 'fa' ? 'en' : 'fa';
    changeLanguage(newLanguage);
  }

  String getText(Map<String, Map<String, String>> textMap, String key) {
    return textMap[_currentLanguage.value]?[key] ?? textMap['en']?[key] ?? key;
  }

  String getProjectText(String projectKey, String fieldKey) {
    // For project details that have language-specific fields
    final field =
        _currentLanguage.value == 'fa' ? '${fieldKey}_fa' : '${fieldKey}_en';
    return AppStrings.projectDetails[projectKey]?[field] ?? '';
  }

  String getExperienceText(String expKey, String fieldKey) {
    // For experience details that have language-specific fields
    final field =
        _currentLanguage.value == 'fa' ? '${fieldKey}_fa' : '${fieldKey}_en';
    return AppStrings.experienceDetails[expKey]?[field] ?? '';
  }
}
