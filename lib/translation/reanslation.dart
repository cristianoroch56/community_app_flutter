import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'en.dart';
import 'gu.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'gu_IN': guIN,
      };
}
