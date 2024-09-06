import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Mine/viewModel/multi_language_page_view_model.dart';
import 'package:atv/tools/language/lw_language_tool.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MultiLanguagePage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _MultiLanguagePageState();
}

class _MultiLanguagePageState
    extends BaseMvvmPageState<MultiLanguagePage, MultiLanguagePageViewModel> {
  @override
  MultiLanguagePageViewModel viewModelProvider() =>
      MultiLanguagePageViewModel();
  @override
  String? titleName() => LocaleKeys.multi_language_change.tr();
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgDownStar,
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  bool isSupportScrollView() => false;
  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.dp,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var string = viewModel.lauguageDatas[index].values.first;
              var code = viewModel.lauguageDatas[index].keys.first;
              var isCurrent = code == viewModel.currentLauguage;
              return InkWell(
                  onTap: () {
                    viewModel.changeLanguage(context, code);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.dp, vertical: 20.dp),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          string,
                          style: TextStyle(
                              color: isCurrent
                                  ? Colors.white
                                  : const Color(0xff8E8E8E),
                              fontSize: 14.sp,
                              fontWeight: LWFontWeight.normal),
                        )),
                        SizedBox(
                          width: 10.dp,
                        ),
                        Visibility(
                            visible: isCurrent,
                            child: Image.asset(
                              AppIcons.imgCommonCheck,
                              width: 12.dp,
                              height: 8.3.dp,
                            ))
                      ],
                    ),
                  ));
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 1.dp,
              );
            },
            itemCount: viewModel.lauguageDatas.length)
      ],
    );
  }
}
