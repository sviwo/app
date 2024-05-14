#
# Generated file, do not edit.
#

Pod::Spec.new do |s|
  s.name             = 'FlutterPluginRegistrant'
  s.version          = '0.0.1'
  s.summary          = 'Registers plugins with your Flutter app'
  s.description      = <<-DESC
Depends on all your plugins, and provides a function to register them.
                       DESC
  s.homepage         = 'https://flutter.dev'
  s.license          = { :type => 'BSD' }
  s.author           = { 'Flutter Dev Team' => 'flutter-dev@googlegroups.com' }
  s.ios.deployment_target = '11.0'
  s.source_files =  "Classes", "Classes/**/*.{h,m}"
  s.source           = { :path => '.' }
  s.public_header_files = './Classes/**/*.h'
  s.static_framework    = true
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.dependency 'Flutter'
  s.dependency 'device_info'
  s.dependency 'device_info_plus'
  s.dependency 'file_picker'
  s.dependency 'flutter_blue_plus'
  s.dependency 'flutter_keyboard_visibility'
  s.dependency 'geolocator_apple'
  s.dependency 'google_maps_flutter_ios'
  s.dependency 'image_cropper'
  s.dependency 'image_picker_ios'
  s.dependency 'map_launcher'
  s.dependency 'mobile_scanner'
  s.dependency 'package_info'
  s.dependency 'package_info_plus'
  s.dependency 'permission_handler_apple'
  s.dependency 'sentry_flutter'
  s.dependency 'shared_preferences_foundation'
  s.dependency 'url_launcher_ios'
  s.dependency 'webview_flutter_wkwebview'
end
