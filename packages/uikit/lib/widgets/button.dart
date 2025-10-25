import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uikit/themes/app_theme.dart';
import 'package:uikit/utils/platfor_extension.dart';
import 'package:uikit/widgets/card.dart';

abstract class AdaptiveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? minWidth;
  final Color? color;
  final IconData? icon;

  const AdaptiveButton._({
    Key? key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.minWidth,
    this.color,
    this.icon,
  }) : super(key: key);

  factory AdaptiveButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? minWidth,
    Color? color,
  }) = _AdaptiveButtonPrimary;

  factory AdaptiveButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? minWidth,
    Color? color,
  }) = _AdaptiveButtonSecondary;

 factory AdaptiveButton.text({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsetsGeometry? padding,
    Color? color,
  }) = _AdaptiveButtonText;

  // Destructive button
  factory AdaptiveButton.destructive({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? minWidth,
  }) = _AdaptiveButtonDestructive;


  factory AdaptiveButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    required IconData icon,
    required Widget label,
    EdgeInsetsGeometry? padding,
    Color? color,
  }) = _AdaptiveButtonIcon;
}



class _AdaptiveButtonPrimary extends AdaptiveButton {
  const _AdaptiveButtonPrimary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? minWidth,
    Color? color,
  }) : super._(
         key: key,
         onPressed: onPressed,
         child: child,
         padding: padding,
         minWidth: minWidth,
         color: color,
       );

  @override
  Widget build(BuildContext context) => PlatformExtension.when<Widget>(
    cupertino: () => _CupertinoButtonPrimary(
      onPressed: onPressed,
      child: child,
      padding: padding,
      color: color,
    ),
    material: () => _MaterialButtonPrimary(
      onPressed: onPressed,
      child: child,
      padding: padding,
      minWidth: minWidth,
      color: color,
    ),
  );
}

class _AdaptiveButtonSecondary extends AdaptiveButton {
  const _AdaptiveButtonSecondary({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? minWidth,
    Color? color,
  }) : super._(
         key: key,
         onPressed: onPressed,
         child: child,
         padding: padding,
         minWidth: minWidth,
         color: color,
       );

  @override
  Widget build(BuildContext context) => PlatformExtension.when<Widget>(
    cupertino: () => _CupertinoButtonSecondary(
      onPressed: onPressed,
      child: child,
      padding: padding,
      color: color,
    ),
    material: () => _MaterialButtonSecondary(
      onPressed: onPressed,
      child: child,
      padding: padding,
      minWidth: minWidth,
      color: color,
    ),
  );
}

class _AdaptiveButtonText extends AdaptiveButton {
  const _AdaptiveButtonText({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsetsGeometry? padding,
    Color? color,
  }) : super._(
         key: key,
         onPressed: onPressed,
         child: child,
         padding: padding,
         color: color,
       );

  @override
  Widget build(BuildContext context) => PlatformExtension.when<Widget>(
    cupertino: () => _CupertinoButtonText(
      onPressed: onPressed,
      child: child,
      padding: padding,
    ),
    material: () => _MaterialButtonText(
      onPressed: onPressed,
      child: child,
      padding: padding,
      color: color,
    ),
  );
}

class _AdaptiveButtonDestructive extends AdaptiveButton {
  const _AdaptiveButtonDestructive({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? minWidth,
  }) : super._(
         key: key,
         onPressed: onPressed,
         child: child,
         padding: padding,
         minWidth: minWidth,
       );

  @override
  Widget build(BuildContext context) => PlatformExtension.when<Widget>(
    cupertino: () => _CupertinoButtonDestructive(
      onPressed: onPressed,
      child: child,
      padding: padding,
    ),
    material: () => _MaterialButtonDestructive(
      onPressed: onPressed,
      child: child,
      padding: padding,
      minWidth: minWidth,
    ),
  );
}

class _AdaptiveButtonIcon extends AdaptiveButton {
  const _AdaptiveButtonIcon({
    Key? key,
    required VoidCallback? onPressed,
    required IconData icon,
    required Widget label,
    EdgeInsetsGeometry? padding,
    Color? color,
  }) : super._(
         key: key,
         onPressed: onPressed,
         child: label,
         padding: padding,
         color: color,
         icon: icon,
       );

  @override
  Widget build(BuildContext context) => PlatformExtension.when<Widget>(
    cupertino: () => _CupertinoButtonIcon(
      onPressed: onPressed,
      icon: icon!,
      label: child,
      padding: padding,
    ),
    material: () => _MaterialButtonIcon(
      onPressed: onPressed,
      icon: icon!,
      label: child,
      padding: padding,
      color: color,
    ),
  );
}


class _CupertinoButtonPrimary extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const _CupertinoButtonPrimary({
    required this.onPressed,
    required this.child,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(10),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: child,
    );
  }
}

class _CupertinoButtonSecondary extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const _CupertinoButtonSecondary({
    required this.onPressed,
    required this.child,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(10),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: color ?? CupertinoColors.secondarySystemFill.resolveFrom(context),
      child: DefaultTextStyle(
        style: TextStyle(color: CupertinoColors.label.resolveFrom(context)),
        child: child,
      ),
    );
  }
}

class _CupertinoButtonText extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const _CupertinoButtonText({
    required this.onPressed,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: child,
    );
  }
}

class _CupertinoButtonDestructive extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const _CupertinoButtonDestructive({
    required this.onPressed,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(10),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: DefaultTextStyle(
        style: const TextStyle(color: CupertinoColors.white),
        child: child,
      ),
    );
  }
}

class _CupertinoButtonIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Widget label;
  final EdgeInsetsGeometry? padding;

  const _CupertinoButtonIcon({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(10),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 20), const SizedBox(width: 8), label],
      ),
    );
  }
}


class _MaterialButtonPrimary extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? minWidth;
  final Color? color;

  const _MaterialButtonPrimary({
    required this.onPressed,
    required this.child,
    this.padding,
    this.minWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: minWidth != null ? Size(minWidth!, 44) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: child,
    );
  }
}

class _MaterialButtonSecondary extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? minWidth;
  final Color? color;

  const _MaterialButtonSecondary({
    required this.onPressed,
    required this.child,
    this.padding,
    this.minWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: minWidth != null ? Size(minWidth!, 44) : null,
        side: color != null ? BorderSide(color: color ??  theme.colors.onSecondary) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: child,
    );
  }
}

class _MaterialButtonText extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const _MaterialButtonText({
    required this.onPressed,
    required this.child,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: child,
    );
  }
}

class _MaterialButtonDestructive extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? minWidth;

  const _MaterialButtonDestructive({
    required this.onPressed,
    required this.child,
    this.padding,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: minWidth != null ? Size(minWidth!, 44) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: child,
    );
  }
}

class _MaterialButtonIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Widget label;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const _MaterialButtonIcon({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: label,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
