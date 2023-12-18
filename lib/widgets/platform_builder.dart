import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:shared_core_lib/extensions/context.dart';

class PlatformBuilder extends StatelessWidget {
  final DesktopWidgetBuilder? desktop;
  final MobileWidgetBuilder? mobile;
  final Widget placeholder;

  const PlatformBuilder({
    super.key,
    this.desktop,
    this.mobile,
    Widget? placeholder,
  }) : placeholder = placeholder ?? const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    if (context.isDesktopDevice) {
      return desktop?.call(context, Platform.isMacOS, Platform.isWindows, Platform.isWindows) ?? placeholder;
    } else if (context.isMobileDevice) {
      return mobile?.call(context, Platform.isIOS, Platform.isAndroid) ?? placeholder;
    }

    return placeholder;
  }
}

typedef DesktopWidgetBuilder = Widget Function(BuildContext context, bool isMacOS, bool isWindows, bool isLinux);
typedef MobileWidgetBuilder = Widget Function(BuildContext context, bool isIOS, bool isAndroid);
