import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Mine/viewModel/authentication_center_view_model.dart';
import 'package:atv/tools/imagePicker/image_picker_tool.dart';
import 'package:atv/widgetLibrary/basic/button/lw_button.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthenticationCenterPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _AuthenticationCenterPageState();
}

class _AuthenticationCenterPageState extends BaseMvvmPageState<
    AuthenticationCenterPage, AuthenticationCenterViewModel> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyNameController = TextEditingController();
  @override
  AuthenticationCenterViewModel viewModelProvider() =>
      AuthenticationCenterViewModel();
  bool isSupportScrollView() => true;
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgDownStar,
      fit: BoxFit.cover,
    );
  }

  @override
  String? titleName() => LocaleKeys.authentication_center.tr();

  @override
  Widget buildBody(BuildContext context) {
    bool isLegal = viewModel.isLegal;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30.dp,
          ),
          Text(
            LocaleKeys.name.tr(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: LWFontWeight.bold),
          ),
          SizedBox(
            height: 20.dp,
          ),
          _buildNameInputField(),
          SizedBox(
            height: 40.dp,
          ),
          Text(
            LocaleKeys.family_name.tr(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: LWFontWeight.bold),
          ),
          SizedBox(
            height: 20.dp,
          ),
          _buildFamilyNameInputField(),
          SizedBox(
            height: 42.dp,
          ),
          Text(
            LocaleKeys.upload_certificate_picture.tr(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: LWFontWeight.normal),
          ),
          SizedBox(
            height: 36.dp,
          ),
          _buildUploadItems(),
          SizedBox(
            height: 80.dp,
          ),
          _buildNextButton(isLegal),
        ],
      ),
    );
  }

  Widget _buildNameInputField() {
    return SizedBox(
      height: 42.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.authLastName = value;
            pageRefresh(() {});
          },
          onFieldSubmitted: (value) {
            LogUtil.d('-----');
          },
          controller: _nameController,
          autofocus: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            LengthLimitingTextInputFormatter(100)
          ],
          maxLines: 1,
          style: TextStyle(
              fontSize: 12.sp, color: Colors.white, height: SizeUtil.dp(1.5)),
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
          decoration: InputDecoration(
            hintText: LocaleKeys.input_name.tr(),
            hintStyle:
                TextStyle(fontSize: 12.sp, color: const Color(0xff8E8E8E)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.5.dp, vertical: 15.dp),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.dp, color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1.dp, color: const Color(0xff36BCB3)),
            ),
          )),
    );
  }

  Widget _buildFamilyNameInputField() {
    return SizedBox(
      height: 42.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.authFirstName = value;
            pageRefresh(() {});
          },
          onFieldSubmitted: (value) {
            LogUtil.d('-----');
          },
          controller: _familyNameController,
          autofocus: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            LengthLimitingTextInputFormatter(100)
          ],
          maxLines: 1,
          style: TextStyle(
              fontSize: 12.sp, color: Colors.white, height: SizeUtil.dp(1.5)),
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
          decoration: InputDecoration(
            hintText: LocaleKeys.input_faimily_name.tr(),
            hintStyle:
                TextStyle(fontSize: 12.sp, color: const Color(0xff8E8E8E)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.5.dp, vertical: 15.dp),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.dp, color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1.dp, color: const Color(0xff36BCB3)),
            ),
          )),
    );
  }

  Widget _buildUploadItems() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.dp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                ImagePickerTool.showChooseImagePicker(
                  context,
                  completion: (type, files) {
                    viewModel.setFrontImage(files.first);
                  },
                );
              },
              child: viewModel.certificateFrontImgFile == null
                  ? DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(11.dp),
                      // padding: EdgeInsets.all(6),
                      color: Colors.white,
                      child: Container(
                        width: 120.dp,
                        height: 120.dp,
                        alignment: Alignment.center,
                        child: Text(
                          "+",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23.dp,
                              fontWeight: LWFontWeight.bold),
                        ),
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(11.dp),
                      child: Image.memory(
                        viewModel.frontImage,
                        fit: BoxFit.cover,
                        width: 120.dp,
                        height: 120.dp,
                      ),
                    )),
          InkWell(
              onTap: () {
                ImagePickerTool.showChooseImagePicker(
                  context,
                  completion: (type, files) {
                    viewModel.setBackImage(files.first);
                  },
                );
              },
              child: viewModel.certificateBackImgFile == null
                  ? DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(11.dp),
                      // padding: EdgeInsets.all(6),
                      color: Colors.white,
                      child: Container(
                        width: 120.dp,
                        height: 120.dp,
                        alignment: Alignment.center,
                        child: Text(
                          "+",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23.dp,
                              fontWeight: LWFontWeight.bold),
                        ),
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(11.dp),
                      child: Image.memory(
                        viewModel.backImage,
                        fit: BoxFit.cover,
                        width: 120.dp,
                        height: 120.dp,
                      ),
                    ))
        ],
      ),
    );
  }

  Widget _buildNextButton(bool isLegal) {
    return LWButton.text(
      text: LocaleKeys.submit.tr(),
      textColor: const Color(0xff010101),
      textSize: 16.sp,
      backgroundColor: isLegal ? Colors.white : const Color(0xffA8A8A8),
      minWidth: 315.dp,
      minHeight: 50.dp,
      enabled: isLegal,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.dp))),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        viewModel.submmitData();
      },
    );
  }
}
