// import 'package:fe_arch_flutter/data/entity/res_data.dart';
// import 'package:fe_arch_flutter/data/entity/res_list.dart';
// import 'package:fe_arch_flutter/data/net/http.dart';
// import 'package:fe_arch_flutter/data/net/http_helper.dart';
// import 'package:fe_arch_flutter/utils/log_util.dart';
// import 'package:pcrm_flutter/data/entity/briefing/mline/mline_data_competition.dart';
// import 'package:pcrm_flutter/data/entity/briefing/mline/mline_data_home.dart';
// import 'package:pcrm_flutter/data/entity/briefing/mline/mline_data_profit.dart';
// import 'package:pcrm_flutter/data/entity/briefing/mline/mline_detail.dart';
// import 'package:pcrm_flutter/data/entity/briefing/mline/mline_detail_profit.dart';
// import 'package:pcrm_flutter/data/entity/briefing/mline/mline_person_home.dart';
// import 'package:pcrm_flutter/data/entity/briefing/mline/mline_property_home.dart';
// import 'package:pcrm_flutter/data/entity/briefing/mline/req/req_mline_home.dart';
// import 'package:pcrm_flutter/data/entity/briefing/pline/pline_home_operation_category.dart';
// import 'package:pcrm_flutter/data/entity/briefing/pline/pline_home_operation_category_item.dart';
// import 'package:pcrm_flutter/data/entity/briefing/pline/pline_home_task_count.dart';
// import 'package:pcrm_flutter/data/entity/briefing/pline/pline_home_task_list_model.dart';
// import 'package:pcrm_flutter/ui/page/briefing/pline/defines/pline_home_defines.dart';

// class ApiBriefing {
//   ApiBriefing._internal();

//   /// ================== P线 ==================

//   /// 获取指标分类
//   static Future<ResData<List<PLineHomeOperationCategory>>> indexCategory() async {
//     try {
//       var urlPath = 'buln/home/indicator/indexCategory';

//       var responseData = await Http.instance().get(urlPath);
//       return HttpHelper.httpListConvert<List<PLineHomeOperationCategory>>(responseData, ((json) {
//         return json.map((j) => PLineHomeOperationCategory.fromJson(j)).toList();
//       }));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 获取目标值与完成值
//   static Future<ResData<List<PLineHomeOperationCategoryItem>>> goalAndAchievement(String indexType) async {
//     try {
//       var urlPath = 'buln/home/indicator/goalAndAchievement';

//       var responseData = await Http.instance().get(urlPath, params: {"indexType": indexType});
//       return HttpHelper.httpListConvert<List<PLineHomeOperationCategoryItem>>(responseData, ((json) {
//         return json.map((j) => PLineHomeOperationCategoryItem.fromJson(j)).toList();
//       }));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 获取工作任务大类
//   static Future<ResData<List<PLineHomeTaskCountModel>>> taskCount() async {
//     try {
//       var urlPath = 'buln/work-task/count';

//       var responseData = await Http.instance().get(urlPath);
//       return HttpHelper.httpListConvert<List<PLineHomeTaskCountModel>>(responseData, ((json) {
//         return json.map((j) => PLineHomeTaskCountModel.fromJson(j)).toList();
//       }));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 获取工作任务具体有哪些
//   static Future<ResData<ResList<PLineHomeTaskListModel>>> taskList(
//     String bizKey,
//     List<String> taskCodeList, {
//     int pageNum = 1,
//     int pageSize = 20,
//   }) async {
//     try {
//       var urlPath = 'buln/work-task/list';

//       Map<String, dynamic> params = {
//         'pageNum': pageNum,
//         'pageSize': pageSize,
//         "bizKey": bizKey,
//         "taskCodeList": taskCodeList
//       };

//       LogUtil.d('---------params:$params');

//       var responseData = await Http.instance().get(urlPath, params: params);
//       return await HttpHelper.httpDataConvert<ResList<PLineHomeTaskListModel>>(responseData, (json) {
//         return ResList<PLineHomeTaskListModel>.fromJson(json, (j) {
//           return PLineHomeTaskListModel.fromJson(j);
//         });
//       });
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 工作台-工作任务列表
//   static Future<ResData<ResList<PLineHomeTaskListModel>>> allTaskList(
//     PLineWorkTaskListRequest request, {
//     int pageNum = 1,
//     int pageSize = 20,
//   }) async {
//     try {
//       var urlPath = 'project/app/task/list';

//       Map<String, dynamic> params = {
//         'pageNum': pageNum,
//         'pageSize': pageSize,
//         'status': request.status,
//         'asc': request.asc
//       };
//       if (request.buildingName?.isNotEmpty == true) {
//         params['buildingName'] = request.buildingName;
//       }
//       if (request.userCode?.isNotEmpty == true) {
//         params['userCode'] = request.userCode;
//       }
//       if (request.bizKey?.isNotEmpty == true) {
//         params['bizKey'] = request.bizKey;
//       }

//       var responseData = await Http.instance().post(urlPath, data: params);
//       return await HttpHelper.httpDataConvert<ResList<PLineHomeTaskListModel>>(responseData, (json) {
//         return ResList<PLineHomeTaskListModel>.fromJson(json, (j) {
//           return PLineHomeTaskListModel.fromJson(j);
//         });
//       });
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// ================== M线-主页 ==================

//   /// 盘数-媒资KPI-财务维度
//   /// body: ReqMLineHome
//   static Future<ResData<MLineDataHome>> getKpiFinance(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/data/count/finance', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDataHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-媒资KPI--规模维度
//   /// body: ReqMLineHome
//   static Future<ResData<MLineDataHome>> getKpiScale(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/data/count/scale', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDataHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }


//   /// 盘数-媒资KPI--规模维度--查看趋势
//   /// body: ReqMLineHome
//   static Future<ResData<MLineDataProfitScaleLine>> getKpiScaleLine(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/data/count/scale/line', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDataProfitScaleLine.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }


//   /// 盘数-媒资KPI--质量维度
//   /// body: ReqMLineHome
//   static Future<ResData<MLineDataHome>> getKpiQuality(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/data/count/quality', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDataHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-盈亏分析
//   /// body: ReqMLineHome
//   static Future<ResData<MLineDataProfit>> getProfitAnalysis(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/data/count/profit/analysis', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDataProfit.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-竞媒比对
//   /// body: ReqMLineHome
//   static Future<ResData<MLineDataCompetition>> getDataCompetition(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/data/count/media', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDataCompetition.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-楼盘品质运营
//   /// body: ReqMLineHome
//   static Future<ResData<MLineDataHome>> getDataBuilding(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/data/count/quality/build', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDataHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-楼盘九宫格
//   /// body: ReqMLineHome
//   static Future<ResData<MLineDataHome>> getDataSudoku(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/data/count/buildSudoku', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDataHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-楼盘九宫格详情
//   static Future<ResData<MLineDetail>> getBuildingSudokuDetail(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post('buln/board/data/detail/suDoKuDetail', data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-工作饱和度
//   /// body: ReqMLineHome
//   static Future<ResData<MLinePersonHome>> getWorkSaturation(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/boardPerson/workSaturation', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLinePersonHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-人才盘点
//   /// body: ReqMLineHome
//   static Future<ResData<MLinePersonHome>> getTalentInventory(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/boardPerson/talentInventory', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLinePersonHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-人才九宫格
//   /// body: ReqMLineHome
//   static Future<ResData<MLinePersonHome>> getPersonSudoku(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/boardPerson/personSudoku', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLinePersonHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘物业-人才九宫格
//   /// body: ReqMLineHome
//   static Future<ResData<MLinePropertyHome>> getPropertyHome(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance().post('buln/board/property/count', data: req);
//       return await HttpHelper.httpDataConvert(data, (data) => MLinePropertyHome.fromJson(data));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// ================== M线-详情 ==================

//   /// 盘数-获取财务收入,财务成本,财务利润,财务媒资点位成本占收入比例，财务媒资租金成本占收入比例，详情数据
//   static Future<ResData<MLineDetail>> getFinanceDetailByName(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post("buln/board/data/detail/finance", data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-获取规模社区屏,规模商务屏,规模LCD屏,详情数据
//   static Future<ResData<MLineDetail>> getScreenDetailByLine(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post("buln/board/data/detail/scale", data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-质量维度-白名单-TOP楼开发
//   static Future<ResData<MLineDetail>> getTopBuilding(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'topBuilding';
//       var data = await Http.instance().post('buln/board/data/detail/quality', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-质量维度-白名单-TOP客户地址开发
//   static Future<ResData<MLineDetail>> getTopCustomer(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'topCustomers';
//       var data = await Http.instance().post('buln/board/data/detail/quality', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-质量维度-主城核心区占比
//   static Future<ResData<MLineDetail>> getCityMajor(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'codeAreaRatio';
//       var data = await Http.instance().post('buln/board/data/detail/quality', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-质量维度-音量合格率
//   static Future<ResData<MLineDetail>> getVolumnPass(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'volumePassRate';
//       var data = await Http.instance().post('buln/board/data/detail/volume', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-质量维度-计费可售比
//   static Future<ResData<MLineDetail>> getBillingSale(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'billableSalesRatio';
//       var data = await Http.instance().post('buln/board/data/detail/quality', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-质量维度-联网率
//   static Future<ResData<MLineDetail>> getNetworking(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'connectionRate';
//       var data = await Http.instance().post('buln/board/data/detail/quality', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-盈亏分析详情
//   static Future<ResData<MLineDetail>> getProfitAnalysisDetail(ReqMLineHome? req) async {
//     try {
//       var data = await Http.instance()
//           .post('buln/board/data/detail/profit/loss/cooperate', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-竞媒对比详情
//   static Future<ResData<MLineDetail>> getCompetitionDetail(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'media';
//       var data = await Http.instance().post('buln/board/data/detail/media', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-楼盘品质运营-季度到期项目数
//   static Future<ResData<MLineDetail>> getBuildingRenew(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'buildRenew';
//       var data = await Http.instance().post('buln/board/data/detail/build/renew', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘数-楼盘品质运营-楼盘评级
//   static Future<ResData<MLineDetail>> getBuildingGrade(ReqMLineHome? req) async {
//     try {
//       req?.indicatorName = 'buildRank';
//       var data = await Http.instance().post('buln/board/data/detail/build/rank', data: req);
//       return await HttpHelper.httpDataConvert(data, (json) => MLineDetail.fromJson(json));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-工作饱和度-P线日均拜访
//   static Future<ResData<MLineDetail>> getDailyVisitPLine(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post('buln/boardPersonDetail/pLineDailyVisit', data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-人才盘点-人项比实际
//   static Future<ResData<MLineDetail>> getPersonProject(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post("buln/boardPersonDetail/personCompareReality", data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-人才盘点-M线绩效合格率
//   static Future<ResData<MLineDetail>> getPersonPassPerformanceM(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post('buln/boardPersonDetail/mLineScoreRate', data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-人才盘点-P线绩效合格率
//   static Future<ResData<MLineDetail>> getPersonPassPerformanceP(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post('buln/boardPersonDetail/pLineScoreRate', data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-人才盘点-M线技能合格率
//   static Future<ResData<MLineDetail>> getPersonPassSkillM(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post('buln/boardPersonDetail/mLineSkillRate', data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-人才盘点-P线技能合格率
//   static Future<ResData<MLineDetail>> getPersonPassSkillP(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post('buln/boardPersonDetail/pLineSkillRate', data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }

//   /// 盘人-人才九宫格详情
//   static Future<ResData<MLineDetail>> getPersonSudokuDetail(ReqMLineHome params) async {
//     var paramsMap = params.toJson();
//     paramsMap.removeWhere((key, value) => value == null);
//     try {
//       var data = await Http.instance().post("buln/boardPersonDetail/suDoKuDetail", data: paramsMap);
//       return await HttpHelper.httpDataConvert(data, (data) => MLineDetail.fromJson((data)));
//     } catch (e) {
//       throw HttpHelper.handleException(e);
//     }
//   }
// }
