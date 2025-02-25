import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

List<String> getLanguageItems(BuildContext context){
  final currentLocale = context.locale;
  if(currentLocale == const Locale('vi')){
    return ['Tiếng Việt', 'English'];
  } else {
    return ['English', 'Tiếng Việt'];
  }
}

void changeLanguage(BuildContext context, String? selectedLanguage, VoidCallback onChanged){
  if(selectedLanguage == null) return;
  if(selectedLanguage == 'Tiếng Việt' && context.locale != const Locale('vi')){
    context.setLocale(const Locale('vi'));
  } else if (selectedLanguage == 'English' && context.locale!= const Locale('en')){
    context.setLocale(const Locale('en'));
  }
  onChanged();
}

String getCurrentLanguageDisplay(BuildContext context){
  return context.locale == const Locale('vi') ? 'Tiếng Việt' : 'English';
}