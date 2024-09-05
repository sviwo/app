import 'dart:ffi';

import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:basic_utils/basic_utils.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ThirdPartLoginTool {
  ThirdPartLoginTool._();
  static Future<AuthorizationCredentialAppleID> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    LogUtil.d('--------开始苹果登录，返回值为${credential.toJson()}}');

    return credential;
  }

  static Future<Map<String, dynamic>> signInWithFacebook() async {
    return {};
    // final LoginResult result = await FacebookAuth.instance
    //     .login(); // by default we request the email and the public profile
    // var map = <String, dynamic>{};
    // if (result.status == LoginStatus.success) {
    //   // you are logged
    //   final AccessToken? accessToken = result.accessToken;

    //   map['accessToken'] = accessToken?.token ?? '';

    //   map['userId'] = accessToken?.userId ?? '';

    //   Map<String, dynamic> userData =
    //       await FacebookAuth.instance.getUserData(fields: "name,email");

    //   LogUtil.d("facebook 获取登录用户信息" + userData.toString());

    //   map.addAll(userData);
    // } else {
    //   LogUtil.d("facebook 登录失败,原因：${result.message}");
    //   if (StringUtils.isNotNullOrEmpty(result.message)) {
    //     LWToast.show(result.message ?? '');
    //   }
    // }
    // return map;
  }
}
// const AuthorizationCredentialAppleID({
//     @required this.userIdentifier,
//     @required this.givenName,
//     @required this.familyName,
//     required this.authorizationCode,
//     @required this.email,
//     @required this.identityToken,
//     @required this.state,
//   });

extension AuthorizationCredentialAppleIDMap on AuthorizationCredentialAppleID {
  Map<String, dynamic> toJson() {
    return {
      'userIdentifier': userIdentifier,
      'givenName': givenName,
      'familyName': familyName,
      'authorizationCode': authorizationCode,
      'email': email,
      'identityToken': identityToken,
      'state': state
    };
  }
}
