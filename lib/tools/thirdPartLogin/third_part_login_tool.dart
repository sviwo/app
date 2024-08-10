import 'package:atv/archs/utils/log_util.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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
    final result = credential.toJson();
    LogUtil.d('--------开始苹果登录，返回值为$result');
    return credential;
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
