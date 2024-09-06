// import 'package:fe_arch_flutter/data/entity/res_data.dart';
// import 'package:fe_arch_flutter/data/entity/res_list.dart';
// import 'package:fe_arch_flutter/data/net/http.dart';
// import 'package:fe_arch_flutter/data/net/http_helper.dart';
// import 'package:pcrm_flutter/conf/app_conf.dart';
// import 'package:pcrm_flutter/data/entity/common/employee.dart';
// import 'package:pcrm_flutter/data/entity/common/industry.dart';
// import 'package:pcrm_flutter/data/entity/common/inner_user.dart';
// import 'package:pcrm_flutter/data/entity/common/project_chooser.dart';
// import 'package:pcrm_flutter/data/entity/common/req/req_project_chooser.dart';
// import 'package:pcrm_flutter/data/entity/others/big_area_info.dart';
// import 'package:pcrm_flutter/data/entity/others/city_info.dart';
// import 'package:pcrm_flutter/data/entity/others/member_info.dart';
// import 'package:pcrm_flutter/data/entity/project/common/city_region.dart';

// import '../entity/others/dict_info.dart';

// class ApiCommon {
//   ApiCommon._internal();

//   /// 查询行业列表
//   /// params:
//   ///   - type 查询数据范围 0:全量数据 1:有效数据
//   static Future<ResData<List<Industry>>> queryIndustry(int? type) async {
//     try {
//       var data = await Http.instance().get('project/industry-data/list/tree', params: {'type': type});
//       return await HttpHelper.httpListConvert(data, (json) {
//         return json.map((e) => Industry.fromJson(e)).toList();
//       });
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 查询员工列表
//   /// params:
//   ///   - pageNum
//   ///   - pageSize
//   ///   - name 用户名称
//   static Future<ResData<ResList<Employee>>> queryEmployee(int pageNum, int pageSize, String? name) async {
//     try {
//       var data = await Http.instance()
//           .get('admin/user/page/userInfo', params: {'pageNum': pageNum, 'pageSize': pageSize, 'name': name});
//       return await HttpHelper.httpDataConvert(
//           data, (data) => ResList.fromJson(data, (data) => Employee.fromJson(data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 是否内部用户
//   /// path:
//   ///   - userId 用户ID
//   static Future<ResData<InnerUser>> isInnerUser() async {
//     try {
//       var userId = (await AppConf.userInfo()).sysUser?.userId;
//       var data = await Http.instance().get('project/project-info/user/$userId');
//       return await HttpHelper.httpDataConvert(data, (data) => InnerUser.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 查询工作报告的角色
//   /// result:
//   ///   - m_line->property_line->p_line，从左至右优先级逐步降低
//   static Future<ResData<List<String>>> getWorkReportRoles() async {
//     try {
//       var data = await Http.instance().get('project/basicsRole/classify/code');
//       return await HttpHelper.httpListConvert(data, (json) {
//         return json.map((e) => e.toString()).toList();
//       });
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 查询项目三要素（共绝大多数选择项目的模块使用）
//   ///   - funcType, 功能类型，用于调用不同的后端接口（PS，后端为每一个功能提供了独立接口，返回的数据对象一致）
//   static Future<ResData<ResList<ProjectChooser>>> getProjectChooser(String? funcType, ReqProjectChooser params) async {
//     try {
//       var data =
//           await Http.instance().get('project/app/building/common/building/query/$funcType', params: params.toJson());
//       return await HttpHelper.httpDataConvert(
//           data, (data) => ResList.fromJson(data, (data) => ProjectChooser.fromJson(data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 获取字典集合（全量）
//   static Future<ResData<List<DictInfo>>> getDictionaryAll() async {
//     try {
//       var data = await Http.instance().get('comtag/dataDictionary/allData');
//       // var data1 = await HttpHelper.httpEmptyConvert(data);
//       // var list = <DictInfo>[];
//       // for (var index = 0; index < )
//       return await HttpHelper.httpListConvert(data, (json) {
//         return json.map((e) {
//           return DictInfo.fromJson(e);
//         }).toList();
//       });
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 获取字典集合（批量）
//   static Future<ResData<List<DictInfo>>> getDictionaryList(List<String> params) async {
//     try {
//       var data = await Http.instance().post('comtag/dataDictionary/loadDataDictionary', data: params);
//       return await HttpHelper.httpListConvert(data, (json) {
//         return json.map((e) => DictInfo.fromJson(e)).toList();
//       });
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 获取城市集合
//   static Future<ResData<List<CityInfo>>> getCityList() async {
//     try {
//       var data = await Http.instance().get('pcrm/polity/appArea');
//       return await HttpHelper.httpListConvert(data, (json) {
//         return json.map((e) => CityInfo.fromJson(e)).toList();
//       });
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 获取城市集合
//   static Future<List<MemberInfo>> getMemberList() async {
//     try {
//       var data = await Http.instance().get('admin/user/performers');
//       return (data as List<dynamic>).map((e) => MemberInfo.fromJson(e)).toList();
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 获取大区信息
//   static Future<ResData<BigAreaInfo>> getBigAreaInfo(String? cities) async {
//     try {
//       var data = await Http.instance().get('pcrm/cityDesk/areaRange', params: {'cities': cities});
//       return await HttpHelper.httpDataConvert(data, (json) => BigAreaInfo.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   ///城市区域列表
//   static Future<ResData<List<CityRegion>>> getCityRegionList(String cityCode) async {
//     try {
//       var data =
//           await Http.instance().post("pcrm/third/competeMedia/getRegionStatistics", data: {'cityCode': cityCode});
//       return await HttpHelper.httpDataConvert(data, (data) {
//         var list = data['statDetailList'];
//         if (list != null && list is List) {
//           return list.map((e) => CityRegion.fromJson(e)).toList();
//         }
//         return [];
//       });
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }
// }
