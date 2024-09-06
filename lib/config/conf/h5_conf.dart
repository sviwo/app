// import 'dart:convert';
// import 'dart:io';

// import 'package:crypto/crypto.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// import 'app_conf.dart';

// class H5Conf {
//   H5Conf._();

//   /// =====================
//   static const loginSuccess = 'xinchao://loginSuccess';
//   static const pageClose = 'xinchao://close';
//   static const pageBack = 'xinchao://back';
//   static const getToken = 'getToken';
//   static const pagePop = 'pagePop';

//   // H5服务域名
//   static Future<String> get domainUrl async {
//     if ((await AppConf.environment()) != 'prod') {
//       // 从原生传过来的
//       var envInfo = await AppConf.environmentInfo();
//       if (envInfo != null && envInfo.h5Domain != null) {
//         return envInfo.h5Domain!;
//       }
//     }
//     return 'https://${await AppConf.hostPrefix()}res-cloud.xinchao.com';
//   }

//   /// ===================== PCRM
//   // 根地址
//   static Future<String> get pcrmRoot async {
//     return '${await domainUrl}/pcrm/pcrm-h5/#/';
//   }

//   static Future<String> get pcrmLogin async {
//     var pumaDomain = 'https://${await AppConf.hostPrefix()}portal.xinchao.com';
//     if ((await AppConf.environment()) != 'prod') {
//       // 从原生传过来的
//       var envInfo = await AppConf.environmentInfo();
//       if (envInfo != null && envInfo.pumaDomain != null) {
//         pumaDomain = envInfo.pumaDomain!;
//       }
//     }
//     var version = (await PackageInfo.fromPlatform()).version;
//     return '$pumaDomain/h5_index.html#/login?'
//         'loginType=pwd&loginSource=pig-auth&productCode=pig-auth&registerId=${await _registerId}&appVersion=$version';
//   }

//   static Future<String> get _registerId async {
//     var env = await AppConf.environment();
//     if (env != 'prod') {
//       // 从原生传过来的
//       var envInfo = await AppConf.environmentInfo();
//       if (envInfo != null && envInfo.pumaRegisterId != null) {
//         return envInfo.pumaRegisterId!;
//       }
//     }
//     return {'dev': '337890B25ZY3XKAW', 'sit': '337890B1HAY49028', 'uat': '337890B3F2DA7YNC'}[env] ?? '337890B4BFMX186W';
//   }

//   // 合同管理主入口
//   static Future<String> get contractHome async {
//     return '${await domainUrl}/pcrm/contract-h5';
//   }

//   // 合同详情
//   static Future<String> get contractDetail async {
//     return '${await contractHome}/#/contractDetail?id=%s&sourceType=1';
//   }

//   // 合同草稿详情
//   static Future<String> get contractDraftDetail async {
//     return '${await contractHome}/#/floorLinkContract?contractId=%s';
//   }

//   //屏安装工单安装原因提示页面
//   static Future<String> get orderInstallReasonScreen async {
//     return '${await pcrmRoot}tips-reason?type=0';
//   }

//   //框安装工单安装原因提示页面
//   static Future<String> get orderInstallReasonFrame async {
//     return '${await pcrmRoot}tips-reason?type=1';
//   }

//   //屏拆除工单拆除原因提示页面
//   static Future<String> get orderDismantleReasonScreen async {
//     return '${await pcrmRoot}tips-reason?type=2';
//   }

//   //框拆除工单拆除原因提示页面
//   static Future<String> get orderDismantleReasonFrame async {
//     return '${await pcrmRoot}tips-reason?type=3';
//   }

//   // 开楼申请详情（必须使用登录用户的ID，不支持外部传入）
//   static Future<String> get openApplyDetail async {
//     var userId = (await AppConf.userInfo()).sysUser?.userId;
//     return '${await domainUrl}/pcrm/h5pcrm/#/building-application/detail?projectSignUpUuid=%s&loginUserId=$userId&cityCode=%s';
//   }

//   // 价格测算
//   static Future<String> get openApplyPointsInteractive async {
//     return '${await domainUrl}/pcrm/h5pcrm/#/referenceQuotation/index';
//   }

//   // 工作报告（信息化-旧版）
//   static Future<String> get workReportOld async {
//     var env = await AppConf.environment();
//     var domain = env == 'prod' ? 'https://pcrmreport.xinchao.com/ding.php' : 'http://t-pcrmreport.xinchao.com/ding.php';
//     var jobNo = (await AppConf.userInfo()).sysUser?.username ?? '';
//     var timestamp = DateTime.now().second;
//     var version = (await PackageInfo.fromPlatform()).version;
//     var sign = md5
//         .convert(utf8.encode('0583ce056d0a2ee016bff82c730676a5${jobNo}0583ce056d0a2ee016bff82c730676a5${timestamp}'))
//         .toString();
//     return '${domain}?m=report&a=appLoginAuth&sign=$sign&staffsn=$jobNo&timestamp=$timestamp&version=V$version';
//   }

//   /// ===================== 广告
//   // 根地址
//   static Future<String> get adRoot async {
//     //return 'https://t-res-cloud.xinchao.com/ad/';
//     return '${await domainUrl}/ad/';
//   }

//   // 竞媒比对
//   static Future<String> get adCompareLaunch async {
//     return '${await adRoot}digital-publish-sales-tools-h5/#/competitiveMedia/Index';
//   }

//   static Future<String> get adCompareMap async {
//     // return 'http://10.200.120.37:3000/#/competitiveMedia/map?source=pcrm';
//     return '${await adRoot}digital-publish-sales-tools-h5/#/competitiveMedia/map?source=pcrm';
//   }

//   // 楼盘详情
//   static Future<String> get adBuildingDetail async {
//     // 点位数据来自预发布，查看楼盘详情时，也需要用预发布环境的链接
//     String root = await adRoot;
//     var env = await AppConf.environment();
//     if (env != 'prod') {
//       root = 'https://p-res-cloud.xinchao.com/ad/';
//     }
//     // source=cgz 不显示标题栏
//     return '${root}digital-publish-sales-tools-h5/#/one_page?buildingId=%s&source=cgz';
//   }

//   /// ===================== DCRM
//   // 根地址
//   static Future<String> get salesRoot async {
//     //return 'https://t-res-cloud.xinchao.com/dcrm/';
//     return '${await domainUrl}/dcrm/';
//   }

//   // 销售工具包
//   static Future<String> get salesTool async {
//     return '${await salesRoot}sale-tools-h5/#/';
//   }

//   // 公司介绍
//   static Future<String> get salesCompanyIntroduce async {
//     return 'https://m.xinchao.com?token=0b202e90d4513e38fdb19533f39f11c5';
//   }

//   // 白皮书
//   static Future<String> get salesWhitePaper async {
//     return '${await salesTool}list/120100?source=pcrm&menuId=120100&title=白皮书&contactMobile=18030220306&contactEmail=linhao@xinchao.com&contactPerson=林浩(XC17247)&showStyle=0';
//   }

//   // 硬产品介绍
//   static Future<String> get salesHardProduct async {
//     return '${await salesTool}list/120400?source=pcrm&menuId=120400&title=硬产品介绍&contactMobile=18030220306&contactEmail=linhao@xinchao.com&contactPerson=林浩(XC17247)&showStyle=0';
//   }

//   // 大媒体
//   static Future<String> get salesMediaLarge async {
//     return '${await salesTool}list/180100?source=pcrm&menuId=180100&title=大媒体&contactMobile=13822280976&contactEmail=wuruiying@xinchao.com&contactPerson=武睿颖(XC18335)&showStyle=2';
//   }

//   // 梯媒
//   static Future<String> get salesMediaElevator async {
//     return '${await salesTool}list/180200?source=pcrm&menuId=180200&title=梯媒&contactMobile=13822280976&contactEmail=wuruiying@xinchao.com&contactPerson=武睿颖(XC18335)&showStyle=2';
//   }

//   // 公关案例文章
//   static Future<String> get salesMediaArticle async {
//     return '${await salesTool}list/180300?source=pcrm&menuId=180300&title=公关案例文章&contactMobile=13822280976&contactEmail=wuruiying@xinchao.com&contactPerson=武睿颖(XC18335)&showStyle=2';
//   }

//   // 文件保存位置说明
//   //  - platform: ios, android, other
//   static Future<String> get salesFileLocation async {
//     return '${await salesTool}afterDownloadTips/${Platform.isIOS ? 'ios' : 'android'}';
//   }
// }
