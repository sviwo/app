import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/paging_view_model.dart';
import 'package:atv/archs/data/entity/res_list.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';
import 'package:atv/config/data/entity/tripRecorder/trip_recorder.dart';
import 'package:atv/config/net/api_home_page.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/define/trip_recorder_list_request.dart';
import 'package:atv/tools/map/lw_map_tool.dart';
import 'package:easy_localization/easy_localization.dart';

class TripRecorderPageViewModel extends PagingViewModel<TripRecorder> {
  var request = TripRecorderListRequest();

  @override
  Future<void> loadData({isRefresh = true, bool showLoading = false}) async {
    request.pageNum = getPageNum(isRefresh);
    request.pageSize = getPageSize();
    loadPaging(ApiHomePage.getTripRecorderList(request), isRefresh,
        showLoading: showLoading, errorMsg: LocaleKeys.no_data_tips.tr());
  }

  void delete(String travelRecordId) {
    loadApiData(
      ApiHomePage.deleteTripRecorder(travelRecordId),
      handlePageState: false,
      showLoading: true,
      voidSuccess: () {
        listData
            .removeWhere((element) => element.travelRecordId == travelRecordId);
        totalSize--;
        updatePageState(totalSize <= 0 ? PageState.empty : PageState.content);
      },
    );
  }

  // String duration(TripRecorder model){
  //   model.startTime
  // }

  //updatePageState(totalSize <= 0 ? PageState.empty : PageState.content);

  Future<String> reverseGeocoding(TripRecorder listModel, bool isStart) async {
    if (isStart && listModel.startPointString.isNotEmpty) {
      return listModel.startPointString;
    }
    if (isStart == false && listModel.endPointString.isNotEmpty) {
      return listModel.endPointString;
    }

    GeoLocationDefine? point = listModel.startPoint;
    if (isStart == false) {
      point = listModel.endPoint;
    }
    var address = '';
    if (point != null) {
      address = await LWMapTool.reverseGeocoding(point);
    }
    if (address.isEmpty) {
      address = '-';
    } else {
      if (isStart) {
        listModel.startPointString = address;
      } else {
        listModel.endPointString = address;
      }
    }

    return address;
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
    loadData(isRefresh: true, showLoading: true);
  }

  @override
  void release() {
    // TODO: implement release
  }
}
