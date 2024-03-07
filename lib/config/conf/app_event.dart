/// 事件
class AppEvent {
  AppEvent._internal();

  // 通用
  static String respectGreat = 'event/respectGreat'; // 致敬XX
  static String deptRefresh = 'event/deptRefresh'; // 组织请求刷新
  static String deptLoadFailed = 'event/deptLoadFailed'; // 组织加载失败
  static String shareMiniProgram = 'event/shareMiniProgram'; // 分享小程序

  /// 设置屏幕方向
  static String setOrientation = 'event/setOrientation';

  /// 项目报备
  static String projectReportCreateSuccess = 'event/projectReportCreateSuccess'; // 项目报备新增/编辑成功
  static String projectReportDraftSuccess = 'event/projectReportDraftSuccess'; // 项目报备新增/编辑草稿成功
  static String projectReportApproveFinish = 'event/projectReportApproveFinish'; // 项目报备审批结束
  static String projectReportDataReady = 'event/projectReportDataReady'; // 项目报备详情数据已就绪
  static String projectReportAddBrandOrPropertySuccess =
      'event/projectReportAddBrandOrPropertySuccess'; // 创建基地品牌、综合体品牌、物业公司、开发商成功

  /// 项目信息
  static String projectInfoListRefresh = 'event/projectInfoListRefresh'; // 刷新项目列表
  static String projectTransferSeaSuccess = 'event/projectTransferSeaSuccess'; // 项目转移到公海成功
  static String projectInfoDetailRefresh = 'event/projectInfoDetailRefresh'; // 刷新项目详情
  static String projectInfoDockingRefresh = 'event/projectInfoDockingRefresh'; // 刷新楼盘对接信息
  static String projectInfoProjectAndPropertyModifySuccess =
      'event/projectInfoProjectAndPropertyModifySuccess'; // 修改项目&物业信息成功
  static String projectInfoContractModifySuccess = 'event/projectInfoContractModifySuccess'; // 修改楼盘签约信息成功
  static String projectInfoUpdateFollowSuccess = 'event/updateFollowSuccess'; // 项目详情，创建跟进
  static String projectInfoOperationSudokuRefresh = 'event/projectInfoOperationSudokuRefresh'; //刷新楼盘详情——楼盘九宫格数据

  /// 开楼申请
  static String projectOpenApplyListRefresh = 'event/projectOpenApplyListRefresh'; // 刷新开楼申请列表
  static String projectOpenApplyCreateSuccess = 'event/projectOpenApplyCreateSuccess'; // 创建开楼申请成功
  static String projectOpenApplyContractSuccess = 'event/projectOpenApplyContractSuccess'; // 开楼转合同成功

  /// 框-安装工单创建成功
  static String workOrderInstallFrameCreateSuccess = "event/workOrderInstallFrameCreateSuccess";

  /// 屏-安装工单创建成功
  static String workOrderInstallScreenCreateSuccess = "event/workOrderInstallScreenCreateSuccess";

  /// 框-安装工单撤销成功
  static String workOrderInstallFrameRevokeSuccess = "event/workOrderInstallFrameRevokeSuccess";

  /// 屏-安装工单撤销成功
  static String workOrderInstallScreenRevokeSuccess = "event/workOrderInstallScreenRevokeSuccess";

  /// 消息中
  //消息统计信息
  static String messageCount = "event/messageCount";
  static String messageListRefresh = "event/messageListRefresh";

  /// 陪访
  static String accompanyCreateSuccess = 'event/accompanyCreateSuccess'; // 创建陪访成功

  /// 日报周报
  /// 日报周报列表刷新
  static String workReportRefreshList = 'event/workReportRefreshList';

  /// 日报周报详情刷新
  static String workReportRefreshDetail = 'event/workReportRefreshDetail';

  /// 手动检查更新
  static String manualCheckUpgrade = 'event/manualCheckUpgrade';

  /// 故障工单批量接单成功
  static String workOrderTroubleBatchReceiveSuccess = "event/orderTroubleBatchReceiveSuccess";

  /// 故障工单批量处理成功
  static String workOrderTroubleBatchHandleSuccess = "event/orderTroubleBatchHandleSuccess";

  ///预拆除 列表刷新
  static String preDismantleListRefresh = "event/preDismantleListRefresh";

  ///项目公海审核 去审核结果 刷新
  static String openSeaApprovalListRefresh = "event/openSeaApprovalListRefresh";

  ///关闭工单申请审核 列表详情刷新 审核成功过后
  static String workOrderAbolishApproveResult = "event/workOrderAbolishApproveResult";

  /// 潮知识 浏览量更新成功
  static String knowledgeViewCountUpdateSuccess = 'event/knowledgeViewCountUpdateSuccess';
  static String knowledgeProjectRecommendClearRemarks = 'event/knowledgeProjectRecommendClearRemarks';

  /// 工单列表 刷新
  static String workOrderListRefresh = 'event/workOrderListRefresh';

  /// 工单列表 切换工单通知左上角按钮变化
  static String workOrderSwitch = 'event/workOrderSwitch';

  /// 工单详情 刷新
  static String workOrderDetailRefresh = 'event/workOrderDetailRefresh';

  /// 测算价格 价格回调成功
  static String h5PriceSuccess = 'event/h5PriceSuccess';

  ///静音申请审核 列表详情刷新 审核成功过后
  static String workOrderVolumeMuteApproveResult = "event/workOrderApprovalVolumeMuteResult";

  //无合同申请审核 列表详情刷新 审核成功过后
  static String workOrderApprovalNoContractResult = "event/workOrderApprovalNoContractResult";

  /// 楼栋
  /// 楼栋信息刷新
  static String buildingInfoRefresh = 'event/buildingInfoRefresh';

  static String workOrderNoContractApproveResult = "event/workOrderApprovalNoContractResult";

  /// M线
  static String mLineHomeRefresh = 'event/mLineHomeRefresh'; // 刷新M线首页
  static String mLineProfitAnalysisDeptChanged = 'event/mLineProfitAnalysisDeptChanged'; // 盈亏分析组织过滤器刷新
  static String mLineHomeBuildingSudokuDataRefresh = 'event/mLineHomeBuildingSudokuDataRefresh'; // 刷新M线楼盘九宫格

  /// 分成账号管理
  static String propertyBabyListRefresh = 'event/propertyBabyListRefresh'; // 刷新分成账号列表
  static String propertyBabyCreateSuccess = 'event/propertyBabyCreateSuccess'; // 分成账号创建成功
  static String propertyBabyDetailRefresh = 'event/propertyBabyDetailRefresh'; // 刷新分成账号详情

  /// 项目跟进-定位成功
  static String followLocationSuccess = 'event/followLocationSuccess';

  /// 项目跟进-跟进位置-数据刷新
  static String locationDataRefresh = 'event/locationDataRefresh';

  /// 项目跟进-跟进列表-数据刷新
  static String projectFollowListRefresh = 'event/projectFollowListRefresh';

  /// 刷新九宫格行动计划
  static String sudokuActionPlanRefresh = 'event/sudokuActionPlanRefresh';

  /// 盈亏测算地址栏事件
  static String profitLossChangeCity = 'event/profitLossChangeCity';
  static String profitLossEnterFormGuideWhenChangeCity = 'event/profitLossEnterFormGuideWhenChangeCity';
  static String profitLossChangeAddress = 'event/profitLossChangeAddress';
  static String profitLossSetAddressInfo = 'event/profitLossSetAddressInfo';

  /// 盈亏测算过滤器变化
  static String profitLossFilterFromAd = 'event/profitLossFilterFromAd';
  static String profitLossFilterToAd = 'event/profitLossFilterToAd';
  static String profitLossFilterToAdSwitchTab = 'event/profitLossFilterToAdSwitchTab';
}
