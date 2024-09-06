import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/main.dart';
import 'package:atv/widgetLibrary/basic/lw_item.dart';
import 'package:atv/widgetLibrary/complex/sheet/lw_sheet_option.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerTool {
  ImagePickerTool._();

  static showChooseImagePicker(BuildContext context,
      {int maxCount = 1, Function(int type, List<XFile> files)? completion}) {
    List<LWItem> options = [
      LWItem(LocaleKeys.open_camera.tr(), 'camera'),
      LWItem(LocaleKeys.open_photo_gallery.tr(), 'gallery')
    ];
    LWSheetOption.single(
      context,
      isDismissible: true,
      options: options,
      onConfirm: (option) {
        if (option.code == 'camera') {
          chooseImage(
            context,
            type: 1,
            completion: completion,
          );
        } else if (option.code == 'gallery') {
          chooseImage(
            context,
            type: 0,
            completion: completion,
          );
        }
      },
    );
  }

  static chooseImage(BuildContext context,
      {
      // 0表示相册，1表示拍照
      int type = 0,
      int maxCount = 1,
      Function(int type, List<XFile> files)? completion}) async {
    if (type == 0) {
      bool isGrant = await checkPhotoPermission();
      if (isGrant == false) {
        // 弹出提示alert
        // ignore: use_build_context_synchronously
        showPhotoAlertDialog(context);
        return;
      }
    } else if (type == 1) {
      bool isGrant = await checkCameraPermisson();
      if (isGrant == false) {
        // 弹出提示alert
        // ignore: use_build_context_synchronously
        showCameraAlertDialog(context);
        return;
      }
    }
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(
        source: type == 0 ? ImageSource.gallery : ImageSource.camera);
    if (completion != null) {
      completion(type, image != null ? [image] : []);
    }
  }

  static showPhotoAlertDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocaleKeys.photo_permission_denied.tr()),
          content: Text(LocaleKeys.grant_photo_permission_in_setting.tr()),
          actions: [
            TextButton(
              child: Text(LocaleKeys.open_settings.tr()),
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
            )
          ],
        );
      },
    );
  }

  static showCameraAlertDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocaleKeys.camera_permission_denied.tr()),
          content: Text(LocaleKeys.grant_camera_permission_in_setting.tr()),
          actions: [
            TextButton(
              child: Text(LocaleKeys.open_settings.tr()),
              onPressed: () async {
                Navigator.of(context).pop();
                await openAppSettings();
              },
            )
          ],
        );
      },
    );
  }

  static Future<bool> checkPhotoPermission() async {
    /// 判断相册权限
    PermissionStatus permissionStatus = await photoPermission();

    if (permissionStatus == PermissionStatus.granted) {
      // 权限已经被授予
      LogUtil.d('照片权限已经被授予');
      return true;
    } else if (permissionStatus == PermissionStatus.denied) {
      // 权限被用户拒绝
      LogUtil.d('照片权限被拒绝');
      // 可以尝试请求权限
      permissionStatus = await requestPhotoPermission();
      LogUtil.d('+++++++');
      if (permissionStatus == PermissionStatus.granted) {
        LogUtil.d('用户同意了权限请求');
        return true;
      } else if (permissionStatus == PermissionStatus.denied) {
        LogUtil.d('用户仍然拒绝了权限请求');
        return false;
      }
    }
    return false;
  }

  static Future<bool> checkCameraPermisson() async {
    /// 判断相机权限
    PermissionStatus permissionStatus = await cameraPermission();
    if (permissionStatus == PermissionStatus.granted) {
      // 权限已经被授予
      LogUtil.d('相机权限已经被授予');
      return true;
    } else if (permissionStatus == PermissionStatus.denied) {
      // 权限被用户拒绝
      LogUtil.d('相机权限被拒绝');
      // 可以尝试请求权限
      permissionStatus = await requestCameraPermission();
      if (permissionStatus == PermissionStatus.granted) {
        LogUtil.d('用户同意了权限请求');
        return true;
      } else if (permissionStatus == PermissionStatus.denied) {
        LogUtil.d('用户仍然拒绝了权限请求');
        return false;
      }
    }
    return false;
  }

  /// 检查相机权限状态
  static Future<PermissionStatus> cameraPermission() async {
    final PermissionStatus permissionStatus = await Permission.photos.status;
    return permissionStatus;
  }

  /// 请求相机权限
  static Future<PermissionStatus> requestCameraPermission() async {
    final PermissionStatus permissionStatus = await Permission.camera.request();
    LogUtil.d('requestCameraPermission permissionStatus:$permissionStatus');
    return permissionStatus;
  }

  /// 检查照片权限状态
  static Future<PermissionStatus> photoPermission() async {
    final PermissionStatus permissionStatus = await Permission.photos.status;
    return permissionStatus;
  }

  /// 请求照片权限
  static Future<PermissionStatus> requestPhotoPermission() async {
    final PermissionStatus permissionStatus = await Permission.photos.request();
    LogUtil.d('requestPhotoPermission permissionStatus:$permissionStatus');
    return permissionStatus;
  }
}
