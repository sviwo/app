import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fe_arch_flutter_platform_interface.dart';

/// An implementation of [FeArchFlutterPlatform] that uses method channels.
class MethodChannelFeArchFlutter extends FeArchFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fe_arch_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
