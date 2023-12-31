import 'package:bloc/bloc.dart';
import 'package:expense_tracker/business%20logic/cubits/theme/theme_state.dart';
import 'package:expense_tracker/theme/pallete.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void toggleTheme(bool isDarkMode) {
    final theme =
        isDarkMode ? Pallete.darkModeAppTheme : Pallete.lightModeAppTheme;
    emit(ThemeChanged(theme));
  }
}
