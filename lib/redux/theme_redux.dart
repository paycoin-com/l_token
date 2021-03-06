import 'package:l_token/config/actions.dart';
import 'package:l_token/style/themes.dart';
import 'package:redux/redux.dart';

final rThemeDataReducer = combineReducers<LTheme>([
  TypedReducer<LTheme, Action>(_toggle),
]);

LTheme _toggle(LTheme theme, action) {
  return theme.isDark() ? kLightTheme : kDarkTheme;
}
