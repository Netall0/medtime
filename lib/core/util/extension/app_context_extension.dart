import 'package:flutter/material.dart';
import 'package:uikit/layout/windows_scope.dart';
import 'package:uikit/themes/app_theme.dart';

extension AppContextExtension on BuildContext{
  LayoutInherited get layout =>  LayoutInherited.of(this);
  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;


}