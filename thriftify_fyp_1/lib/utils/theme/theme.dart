import "package:flutter/material.dart";
import "package:thriftify_fyp_1/utils/theme/custom_themes/elevated_button_theme.dart";
import "package:thriftify_fyp_1/utils/theme/custom_themes/text_theme.dart";
import "package:thriftify_fyp_1/utils/theme/custom_themes/appbar_theme.dart";
import "package:thriftify_fyp_1/utils/theme/custom_themes/bottom_sheet_theme.dart";
import "package:thriftify_fyp_1/utils/theme/custom_themes/checkbox_theme.dart";
import "package:thriftify_fyp_1/utils/theme/custom_themes/chip_theme.dart";
import "package:thriftify_fyp_1/utils/theme/custom_themes/outlined_button_theme.dart";
import "package:thriftify_fyp_1/utils/theme/custom_themes/text_field_theme.dart";

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TTextTheme.lightTextTheme,
      chipTheme: TChipTheme.LightChipTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
      
      
      );
  
  
  
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TTextTheme.darkTextTheme,
      chipTheme: TChipTheme.darkChipTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
      
      );
}
