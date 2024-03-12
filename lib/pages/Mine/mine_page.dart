import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Mine/viewModel/mine_page_view_model.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/complex/file/lw_image_loader.dart';
import 'package:atv/widgetLibrary/form/lw_form_text_multiple.dart';
import 'package:atv/widgetLibrary/form/ui_form_label.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class MinePage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _MinePageState();
}

class _MinePageState
    extends BaseMvvmPageState<BaseMvvmPage, MinePageViewModel> {
  @override
  MinePageViewModel viewModelProvider() => MinePageViewModel();

  @override
  String? titleName() => LocaleKeys.personal_center.tr();

  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgMainPageBg,
      fit: BoxFit.cover,
    );
  }

  @override
  bool isSupportScrollView() => true;

  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 57.dp,
        ),
        _buildHeader(),
        SizedBox(
          height: 50.dp,
        ),
        Divider(
          color: Colors.white,
          height: 0.5.dp,
        ),
        SizedBox(
          height: 17.dp,
        ),
        _buildList()
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.dp),
          width: 90.dp,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(7.5.dp),
                  child: LWImageLoader.network(
                      imageUrl:
                          'https://img1.baidu.com/it/u=1621616811,1488147250&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1710262800&t=7696ef2d7d37554bac6980fdf313e2c4',
                      width: 60.dp,
                      height: 60.dp)),
              SizedBox(
                height: 9.dp,
              ),
              Text(
                'SVIWO',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: LWFontWeight.bold),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Stack(
              fit: StackFit.loose,
              children: [
                Container(
                    width: 172.dp,
                    padding: EdgeInsets.fromLTRB(14.dp, 15.dp, 15.dp, 18.dp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.5.dp),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppIcons.imgMinePageCardBrand,
                              width: 64.5.dp,
                              height: 15.5.dp,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: '99 ',
                                    style: TextStyle(
                                        color: const Color(0xff1B1B1B),
                                        fontSize: 20.sp,
                                        fontWeight: LWFontWeight.bold)),
                                TextSpan(
                                    text: LocaleKeys.km,
                                    style: TextStyle(
                                      color: const Color(0xff1B1B1B),
                                      fontSize: 8.sp,
                                    ))
                              ]),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 14.dp,
                        ),
                        UIFormLabel(LocaleKeys.VIN.tr(),
                            '1561231315312312313512613203513135135135516',
                            fontSize: 8.sp,
                            bottomMargin: 0,
                            labelColor: const Color(0xff1B1B1B),
                            valueColor: const Color(0xff1B1B1B)),
                        SizedBox(
                          height: 9.dp,
                        ),
                        UIFormLabel(LocaleKeys.motor_number.tr(),
                            '1561231315312312313512613203513135135135516',
                            fontSize: 8.sp,
                            bottomMargin: 0,
                            paddingRight: 28.33.dp,
                            labelColor: const Color(0xff1B1B1B),
                            valueColor: const Color(0xff1B1B1B)),
                      ],
                    )),
                Positioned(
                  right: 5.dp,
                  bottom: 2.67.dp,
                  child: IconButton(
                    padding: EdgeInsets.all(10.dp),
                    alignment: Alignment.center,
                    icon: Image.asset(
                      AppIcons.imgMinePageCardDraft,
                      width: 8.33.dp,
                      height: 9.67.dp,
                    ),
                    iconSize: 9.67.dp,
                    onPressed: () {
                      LogUtil.d('点击了删除');
                    },
                  ),
                )
              ],
            ),
            Image.asset(
              AppIcons.imgMinePageCardBottom,
              width: 200.dp,
              height: 5.33.dp,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildList() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 131.dp,
          child: ListView.builder(
            itemCount: viewModel.itemNames.length,
            padding: EdgeInsets.fromLTRB(30.dp, 10.sp, 10.dp, 20.dp),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var itemName = viewModel.itemNames[index];
              bool isAC = itemName == LocaleKeys.authentication_center.tr();
              return Padding(
                padding:
                    EdgeInsets.only(top: 30.dp, bottom: isAC ? 20.dp : 30.dp),
                child: InkWell(
                  onTap: () {
                    LogUtil.d('点击了${viewModel.itemNames[index]}');
                    if (itemName == LocaleKeys.account.tr()) {
                      // 账户
                    } else if (itemName == LocaleKeys.help.tr()) {
                      // 帮助
                      pagePush(AppRoute.authenticationCenter);
                    } else if (itemName == LocaleKeys.multi_language.tr()) {
                      // 多语言
                      pagePush(AppRoute.authenticationCenter);
                    } else if (isAC) {
                      // 认证中心
                      pagePush(AppRoute.authenticationCenter);
                    } else if (itemName == LocaleKeys.quit.tr()) {
                      // 退出
                      pagePush(AppRoute.authenticationCenter);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: isAC
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 21.dp,
                        child: Image.asset(
                          viewModel.itemImageNames[index],
                          width: viewModel.itemImageWidths[index],
                          height: viewModel.itemImageHeights[index],
                        ),
                      ),
                      SizedBox(
                        width: 11.5.dp,
                      ),
                      Expanded(
                          child: isAC
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      itemName,
                                      style: TextStyle(
                                          fontSize: 14.sp, color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 7.3.dp,
                                    ),
                                    Text(
                                      viewModel.verifiedString,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color(0xff36BCB3)),
                                    ),
                                  ],
                                )
                              : Text(
                                  itemName,
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.white),
                                )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: 0.5.dp,
          height: 410.dp,
          color: Colors.white,
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.only(top: 35.dp),
          itemCount: viewModel.productTitles.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(bottom: 44.dp),
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          LogUtil.d('点击了${viewModel.productTitles[index]}');
                        },
                        child: Stack(
                          fit: StackFit.loose,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(7.5.dp),
                                child: LWImageLoader.network(
                                    imageUrl: viewModel.productImageUrls[index],
                                    width: 171.33.dp,
                                    height: 87.03.dp)),
                            Positioned(
                              left: 14.dp,
                              top: 16.dp,
                              child: Text(
                                viewModel.productTitles[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: LWFontWeight.normal),
                              ),
                            ),
                            Positioned(
                              bottom: 14.dp,
                              right: 5.dp,
                              child: Text(
                                viewModel.productDescrips[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.5.sp,
                                    fontWeight: LWFontWeight.normal),
                              ),
                            )
                          ],
                        )),
                    Image.asset(
                      AppIcons.imgMinePageCardBottom,
                      width: 200.dp,
                      height: 5.33.dp,
                      alignment: Alignment.bottomRight,
                    )
                  ],
                ));
          },
        ))
      ],
    );
  }
}
