import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/data/entity/xc_object.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/vehicle_condition_information_page_view_model.dart';
import 'package:atv/widgetLibrary/basic/colors/lw_colors.dart';
import 'package:atv/widgetLibrary/lw_widget.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VehicleConditionInformationPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() =>
      _VehicleConditionInformationPageState();
}

class _VehicleConditionInformationPageState extends BaseMvvmPageState<
    VehicleConditionInformationPage, VehicleConditionInformationPageViewModel> {
  @override
  VehicleConditionInformationPageViewModel viewModelProvider() =>
      VehicleConditionInformationPageViewModel();
  @override
  String? titleName() => LocaleKeys.vehicle_condition_information.tr();
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgUpStar,
      fit: BoxFit.cover,
    );
  }

  @override
  bool isSupportScrollView() => true;

  @override
  Widget buildBody(BuildContext context) {
    var placeHodler = '-';
    return Column(
      children: [
        SizedBox(
          height: 250.dp,
        ),
        _buildRowItem(LocaleKeys.vehicle_name.tr(),
            viewModel.dataModel?.nickname ?? placeHodler),
        SizedBox(
          height: 50.dp,
        ),
        _buildRowItem(LocaleKeys.travlled_distance.tr(),
            (viewModel.dataModel?.mileage ?? '0') + 'KM'),
        SizedBox(
          height: 50.dp,
        ),
        _buildRowItem(LocaleKeys.warranty_date.tr(),
            viewModel.dataModel?.warrantyTime ?? placeHodler),
        SizedBox(
          height: 50.dp,
        ),
        _buildRowItem(LocaleKeys.activation_time.tr(),
            viewModel.dataModel?.activateTime ?? placeHodler),
        SizedBox(
          height: 50.dp,
        ),
        _buildRowItem(LocaleKeys.vin_code.tr(),
            viewModel.dataModel?.deviceName ?? placeHodler),
        SizedBox(
          height: 50.dp,
        ),
      ],
    );
  }

  Widget _buildRowItem(String title, String text) {
    var showEdit = (title == LocaleKeys.vehicle_name.tr()) && viewModel.isOwn;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.dp),
      child: InkWell(
          onTap: () {
            if (showEdit) {
              _showEditNameDialog(viewModel.dataModel?.nickname ?? '');
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.dp,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 5.dp,
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14.dp,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 5.dp,
              ),
              Visibility(
                  visible: showEdit,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.dp),
                    // padding: EdgeInsets.zero,
                    child: Image.asset(
                      AppIcons.imgServiceIndicatorIcon,
                      width: 7.4.dp,
                      height: 12.4.dp,
                    ),
                  ))
            ],
          )),
    );
  }

  _showEditNameDialog(String name) {
    var inputName = name;
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Dialog(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            insetPadding: EdgeInsets.symmetric(horizontal: 20.dp),
            child: Container(
                padding: EdgeInsets.all(20.dp),
                decoration: BoxDecoration(
                    color: Color(0xff090311),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20.dp,
                    ),
                    SizedBox(
                      height: 42.dp,
                      child: TextFormField(
                          onChanged: (value) {
                            inputName = value;
                          },
                          onFieldSubmitted: (value) {},
                          autofocus: false,
                          textAlign: TextAlign.left,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          initialValue: inputName,
                          inputFormatters: [
                            FilteringTextInputFormatter.singleLineFormatter,
                            LengthLimitingTextInputFormatter(100)
                          ],
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              height: SizeUtil.dp(1.5)),
                          strutStyle: const StrutStyle(
                              forceStrutHeight: true, leading: 0),
                          decoration: InputDecoration(
                            hintText: LocaleKeys.please_enter_vehicle_name.tr(),
                            hintStyle: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xff8E8E8E)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.5.dp, vertical: 15.dp),
                            isDense: true,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.dp, color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.dp, color: const Color(0xff36BCB3)),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20.dp,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextButton(
                          child: Text(
                            LocaleKeys.cancel.tr(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.dp),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                        // Container(
                        //   width: 1,
                        //   height: 20.dp,
                        //   color: Colors.white,
                        // ),
                        Expanded(
                            child: TextButton(
                          child: Text(
                            LocaleKeys.confirm.tr(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.dp),
                          ),
                          onPressed: () {
                            viewModel.changeVehicleName(inputName, (isValid) {
                              if (isValid) {
                                Navigator.of(context).pop();
                              }
                            });
                          },
                        )),
                      ],
                    )
                  ],
                )));
      },
    );
  }
}
