import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

enum LogType { error, warning, success, action, info, non, size, curl, location }

class Logger {
  static void e(Object message) {
    logDef(LogType.error, message);
  }

  static void w(Object message) {
    logDef(LogType.warning, message);
  }

  static void s(Object message) {
    logDef(LogType.success, message);
  }

  static void size(Object message) {
    logDef(LogType.size, message);
  }

  static void a(Object message) {
    logDef(LogType.action, message);
  }

  static void i(Object message) {
    logDef(LogType.info, message);
  }

  static void curl(Object message) {
    logDef(LogType.curl, message);
  }

  static void location(Object message) {
    logDef(LogType.location, message);
  }

  static void logDef(LogType logType, Object message) {
    if (kDebugMode) {
      switch (logType) {
        case LogType.error:
          log('', error: '$message', name: '📕');
          break;
        case LogType.warning:
          log('$message', name: '📙');
          break;
        case LogType.success:
          log('$message', name: '📗');
          break;
        case LogType.action:
          log('$message', name: '📘');
          break;
        case LogType.info:
          log('$message', name: 'ℹ️');
          break;
        case LogType.non:
          print('📗📗📗');
          print('info');
          print(message);
          print('📗📗📗');
          break;
        case LogType.size:
          _prints('📙📕📙');
          _prints(message);
          _prints('📙📕📙');
        case LogType.curl:
          log('\n$message', name: 'curl 􀢔');
        case LogType.location:
          log('[location 􀋒]: $message');
      }
    }
  }

  static void logMessage({String title = '', required dynamic message}) {
    if (kDebugMode) {
      _prints('📙📕📙 ${title == '' ? 'size' : title} $message 📙📕📙');
    }
  }

  static void _prints(dynamic s1) {
    String s = s1.toString();
    final pattern = RegExp('.{1,180}');
    // ignore: avoid_print
    pattern.allMatches(s).forEach((match) {
      kIsWeb
          ? print(match.group(0))
          : Platform.isAndroid
          ? print(match.group(0))
          : log(match.group(0).toString());
    });
  }
}
