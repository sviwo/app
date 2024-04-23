import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/base/base_paging_page.dart';
import 'package:atv/archs/conf/arch_conf.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/trip_recorder_page_view_model.dart';
import 'package:atv/widgetLibrary/basic/colors/lw_colors.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TripRecorderPage extends BasePagingPage {
  @override
  State<StatefulWidget> createState() => _TripRecorderPageState();
}

class _TripRecorderPageState
    extends BasePagingPageState<TripRecorderPage, TripRecorderPageViewModel> {
  @override
  TripRecorderPageViewModel viewModelProvider() => TripRecorderPageViewModel();
  @override
  String? titleName() => LocaleKeys.trip_recorder.tr();
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgMainPageBg,
      fit: BoxFit.cover,
    );
  }

  @override
  bool isSupportScrollView() => false;

  @override
  Widget buildBody(BuildContext context) {
    var placeHodler = '-';
    // return SlidableAutoCloseBehavior(
    //     child:

    return SlidableAutoCloseBehavior(
        child: ListView.separated(
            padding: EdgeInsets.all(30.dp),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var model = viewModel.listData[index];
              return Slidable(
                  dragStartBehavior: DragStartBehavior.start,
                  key: Key(uniqueKey()),
                  //左滑划出的菜单
                  endActionPane: ActionPane(
                    key: Key(UniqueKey().toString()),
                    // 菜单宽度
                    extentRatio: 0.2,
                    dragDismissible: false,
                    // 滑动动效
                    // DrawerMotion() StretchMotion()
                    // motion: ScrollMotion(),
                    motion: const BehindMotion(),
                    children: [
                      // SlidableAction(
                      //   // An action can be bigger than the others.
                      //   flex: 2,
                      //   onPressed: doNothing,
                      //   backgroundColor: Color(0xFF7BC043),
                      //   foregroundColor: Colors.white,
                      //   icon: Icons.archive,
                      //   label: 'Archive',
                      // ),
                      SlidableAction(
                        onPressed: (context1) {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  LocaleKeys.reminder.tr(),
                                  style: TextStyle(
                                      fontSize: 20.dp, color: Colors.black),
                                ),
                                content: Text(
                                  LocaleKeys.sure_want_to_delete_trip_record
                                      .tr(),
                                  style: TextStyle(
                                      fontSize: 14.dp, color: Colors.black),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(LocaleKeys.cancel.tr()),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(LocaleKeys.confirm.tr()),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      if (StringUtils.isNotNullOrEmpty(
                                          model.travelRecordId)) {
                                        viewModel
                                            .delete(model.travelRecordId ?? '');
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        backgroundColor: LWColors.theme,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        // label: 'delete',
                      ),
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.dp),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(
                                  13.dp, 13.dp, 13.dp, 18.dp),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Text(
                                          StringUtils.isNotNullOrEmpty(
                                                  model.endTime)
                                              ? (model.endTime ?? placeHodler)
                                              : placeHodler,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: const Color(0xff211B2B)),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 13.dp,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 5.dp),
                                          child: Image.asset(
                                            AppIcons
                                                .imgTripRecorderLocationIcon,
                                            width: 9.dp,
                                            height: 9.dp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.5.dp,
                                        ),
                                        model.startPoint != null
                                            ? Expanded(
                                                child: FutureBuilder(
                                                future:
                                                    viewModel.reverseGeocoding(
                                                        model, true),
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    snapshot.data ??
                                                        placeHodler,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: const Color(
                                                            0xff211B2B)),
                                                  );
                                                },
                                              ))
                                            : Text(
                                                placeHodler,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: const Color(
                                                        0xff211B2B)),
                                              )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18.dp,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 5.dp),
                                          child: Image.asset(
                                            AppIcons
                                                .imgTripRecorderLocationIcon,
                                            width: 9.dp,
                                            height: 9.dp,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.5.dp,
                                        ),
                                        model.endPoint != null
                                            ? Expanded(
                                                child: FutureBuilder(
                                                future:
                                                    viewModel.reverseGeocoding(
                                                        model, false),
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    snapshot.data ??
                                                        placeHodler,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: const Color(
                                                            0xff211B2B)),
                                                  );
                                                },
                                              ))
                                            : Text(
                                                placeHodler,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: const Color(
                                                        0xff211B2B)),
                                              )
                                      ],
                                    ),
                                  ]),
                            ),
                            Container(
                              width: double.infinity,
                              // height: 47.4.dp,
                              color: const Color(0xff211B2B),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoItem(
                                        StringUtils.isNotNullOrEmpty(
                                                model.mileageDriven)
                                            ? (model.mileageDriven ??
                                                placeHodler)
                                            : placeHodler,
                                        'km',
                                        LocaleKeys.travlled_distance.tr()),
                                  ),
                                  Container(
                                    color: const Color(0xff372d46),
                                    width: 1.3.dp,
                                    height: 26.3.dp,
                                  ),
                                  Expanded(
                                    child: _buildInfoItem('28', 'min',
                                        LocaleKeys.travlled_duration.tr()),
                                  ),
                                  Container(
                                    color: const Color(0xff372d46),
                                    width: 1.3.dp,
                                    height: 26.3.dp,
                                  ),
                                  Expanded(
                                    child: _buildInfoItem(
                                        StringUtils.isNotNullOrEmpty(
                                                model.avgSpeed)
                                            ? (model.avgSpeed ?? placeHodler)
                                            : placeHodler,
                                        'km/h',
                                        LocaleKeys.average_speed.tr()),
                                  ),
                                  Container(
                                    color: const Color(0xff372d46),
                                    width: 1.3.dp,
                                    height: 26.3.dp,
                                  ),
                                  Expanded(
                                    child: _buildInfoItem(
                                        StringUtils.isNotNullOrEmpty(
                                                model.consumption)
                                            ? (model.avgSpeed ?? placeHodler)
                                            : placeHodler,
                                        'kwh',
                                        LocaleKeys.energy_usage.tr()),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )));
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 40.dp,
              );
            },
            itemCount: viewModel.listData.length));
  }

  Widget _buildInfoItem(String text, String textUnit, String textDecribe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 8.dp,
        ),
        Text.rich(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            TextSpan(children: [
              TextSpan(
                  text: text,
                  style: TextStyle(
                      fontSize: 20.sp, color: const Color(0xff36BCB3))),
              TextSpan(
                  text: textUnit,
                  style: TextStyle(
                      fontSize: 12.dp, color: const Color(0xff36BCB3))),
            ])),
        SizedBox(
          height: 7.dp,
        ),
        Text(
          textDecribe,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10.dp,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 7.dp,
        )
      ],
    );
  }
}
