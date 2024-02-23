import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_book_study/widgetLibrary/base/base_page.dart';
import 'package:flutter_book_study/widgetLibrary/lw_widget.dart';
import '../basic/font/lw_font_weight.dart';
import '../utils/size_util.dart';
import '../basic/colors/lw_colors.dart';
import '../basic/button/lw_button.dart';
import '../basic/lw_click.dart';
import '../basic/button/lw_button.dart';
import 'routes.dart';

///设计稿 路由主页
class RoutePage extends BasePage {
  RoutePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RoutePageState();
}

class _RoutePageState extends BasePageState<RoutePage> {
  Map<String, String> routeMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        title: const Text(
          "Flutter 书籍学习",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: LWColors.gray7,
          child: ListView.separated(
              itemBuilder: (context, index) {
                var sections = AppRoutesTool.sections(index);
                return Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.dp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.dp),
                          child: Text(
                            AppRoutesTool.chapterName(index),
                            style: TextStyle(
                                fontSize: 20.sp, color: LWColors.gray1,fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: sections.length,
                          padding: EdgeInsets.symmetric(horizontal: 5.dp),
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return Divider(
                              height: 1.dp,
                            );
                          },
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                try {
                                  Navigator.pushNamed(context, sections[index]);
                                } catch (e) {
                                  // not implement
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.dp),
                                child: Text(
                                  AppRoutesTool.sectionName(sections[index]),
                                  style: TextStyle(
                                      fontSize: 14.sp, color: LWColors.gray1),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemCount: AppRoutesTool.chapterCount)),
    );
  }
}
