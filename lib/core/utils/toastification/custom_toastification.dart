import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToastification {
  CustomToastification._();

  static void success(
    BuildContext ctx,
    String msg, {
    Duration duration = const Duration(seconds: 2),
  }) =>
      _show(ctx, msg, _ToastKind.success, duration);

  static void error(
    BuildContext ctx,
    String msg, {
    Duration duration = const Duration(seconds: 3),
  }) =>
      _show(ctx, msg, _ToastKind.error, duration);

  static void info(
    BuildContext ctx,
    String msg, {
    Duration duration = const Duration(seconds: 2),
  }) =>
      _show(ctx, msg, _ToastKind.info, duration);

  static void _show(
    BuildContext ctx,
    String message,
    _ToastKind kind,
    Duration duration,
  ) {
    toastification.show(
      context: ctx,
      title: Text(message,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          )),
      type: kind.type,
      style: ToastificationStyle.flat,
      alignment: Alignment.topCenter,
      backgroundColor: kind.bgColor,
      borderSide: BorderSide.none,
      icon: Icon(kind.icon, color: Colors.white),
      autoCloseDuration: duration,
    );
  }
}

enum _ToastKind { success, error, info }

extension _ToastKindX on _ToastKind {
  ToastificationType get type => switch (this) {
        _ToastKind.success => ToastificationType.success,
        _ToastKind.error => ToastificationType.error,
        _ToastKind.info => ToastificationType.info,
      };

  IconData get icon => switch (this) {
        _ToastKind.success => Icons.check_circle,
        _ToastKind.error => Icons.error,
        _ToastKind.info => Icons.info,
      };

  Color get bgColor => switch (this) {
        _ToastKind.success => Colors.green,
        _ToastKind.error => Colors.red,
        _ToastKind.info => Colors.blue,
      };
}

extension ToastContext on BuildContext {
  void showSuccessToast(String msg) => CustomToastification.success(this, msg);
  void showErrorToast(String msg) => CustomToastification.error(this, msg);
  void showInfoToast(String msg) => CustomToastification.info(this, msg);
}
