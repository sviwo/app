import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fe_arch_flutter_method_channel.dart';

abstract class FeArchFlutterPlatform extends PlatformInterface {
  /// Constructs a FeArchFlutterPlatform.
  FeArchFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static FeArchFlutterPlatform _instance = MethodChannelFeArchFlutter();

  /// The default instance of [FeArchFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelFeArchFlutter].
  static FeArchFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FeArchFlutterPlatform] when
  /// they register themselves.
  static set instance(FeArchFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
