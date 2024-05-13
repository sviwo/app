import 'dart:async';

import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/extension/ext_list.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/scan_code_page_view_model.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodePage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _ScanCodePageState();
}

class _ScanCodePageState
    extends BaseMvvmPageState<ScanCodePage, ScanCodePageViewModel>
    with WidgetsBindingObserver {
  @override
  ScanCodePageViewModel viewModelProvider() => ScanCodePageViewModel();
  @override
  String? titleName() => LocaleKeys.scan_code.tr();
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgNoStar,
      fit: BoxFit.cover,
    );
  }

  Barcode? _barcode;

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false, useNewCameraSelector: true,
    // required options for the scanner
  );

  StreamSubscription<Object?>? _subscription;

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(controller.start());
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    LogUtil.d('释放掉ScanCodePage');
    controller.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!controller.isStarting) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
        break;
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
        break;
    }
  }

  _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      _barcode = barcodes.barcodes.firstOrNull;
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return MobileScanner(
      scanWindow: Rect.largest,
      controller: controller,
      // errorBuilder: (context, error, child) {
      //   return ScannerErrorWidget(error: error);
      // },
      fit: BoxFit.contain,
      onDetect: (BarcodeCapture barcodes) {
        if (barcodes.barcodes.isNotEmpty) {
          var codeInfo = barcodes.barcodes[0];
          if (codeInfo.type != BarcodeType.text) {
            LWToast.show(LocaleKeys.qrcode_format_error_tips.tr());
            pagePop();
            // Future.delayed(const Duration(seconds: 2), () {
            //   pagePop();
            // });
            return;
          }
          var codeString = '';
          if (codeInfo.rawValue != null) {
            codeString = codeInfo.rawValue!;
          }
          if (codeString.isNotEmpty && viewModel.scannedCode != codeString) {
            viewModel.scannedCode = codeString;
            pagePop(resultParams: {'code': codeString});
          }

          // LogUtil.d('开始了');
          // LogUtil.d(codeInfo.calendarEvent);
          // LogUtil.d('calendarEvent------');
          // LogUtil.d(codeInfo.contactInfo);
          // LogUtil.d('contactInfo------');
          // LogUtil.d(codeInfo.corners);
          // LogUtil.d('corners------');
          // LogUtil.d(codeInfo.displayValue);
          // LogUtil.d('displayValue------');
          // LogUtil.d(codeInfo.driverLicense);
          // LogUtil.d('driverLicense------');
          // LogUtil.d(codeInfo.email);
          // LogUtil.d('email------');
          // LogUtil.d(codeInfo.format);
          // LogUtil.d('format------');
          // LogUtil.d(codeInfo.geoPoint);
          // LogUtil.d('geoPoint------');
          // LogUtil.d(codeInfo.phone);
          // LogUtil.d('phone------');
          // LogUtil.d(codeInfo.rawBytes);
          // LogUtil.d('rawBytes------');
          // LogUtil.d(codeInfo.rawValue);
          // LogUtil.d('rawValue------');
          // LogUtil.d(codeInfo.sms);
          // LogUtil.d('sms------');
          // LogUtil.d(codeInfo.type);
          // LogUtil.d('type------');
          // LogUtil.d(codeInfo.url);
          // LogUtil.d('url------');
          // LogUtil.d(codeInfo.wifi);
          // LogUtil.d('wifi------');
        }
      },
    );
    /*
    const Barcode({
    this.calendarEvent,
    this.contactInfo,
    this.corners = const <Offset>[],
    this.displayValue,
    this.driverLicense,
    this.email,
    this.format = BarcodeFormat.unknown,
    this.geoPoint,
    this.phone,
    this.rawBytes,
    this.rawValue,
    this.sms,
    this.type = BarcodeType.unknown,
    this.url,
    this.wifi,
  });
    */
    // return Container(
    //   color: Colors.black,
    //   child: MobileScanner(
    //     scanWindow: Rect.largest,
    //     controller: controller,
    //     // errorBuilder: (context, error, child) {
    //     //   return ScannerErrorWidget(error: error);
    //     // },
    //     fit: BoxFit.contain,
    //     onDetect: (BarcodeCapture barcodes) {
    //       LogUtil.d('扫到了');
    //     },
    //   ),
    // );
  }
}
