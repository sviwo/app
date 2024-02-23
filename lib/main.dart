import 'package:flutter/material.dart';
import 'package:flutter_book_study/widgetLibrary/base/route_page.dart';
import 'package:flutter_book_study/widgetLibrary/base/routes.dart';
import 'package:flutter_book_study/widgetLibrary/complex/loading/lw_loading.dart';
import 'package:flutter_book_study/widgetLibrary/lw_widget.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateDesignDraftRoute,
      title: 'Flutter书籍学习',
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0x01FFFFFF)),
      ),
      home: RoutePage(),
      builder: LWLoading.init(
        builder: (context, widget) {
          LWWidget.init(context);
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget ?? Container(color: Colors.white),
            ),
          );
        },
      ),
    ));
  }
}
