import 'dart:math';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../models/daily_stat_ui_model.dart';
import 'date_util.dart';



class StatController extends GetxController {
  DateTime selectedDate = DateTime.now();
  RxString todayStat = "".obs;
  RxString currentWeek = "".obs;

  RxList<DailyStatUiModel> dailyStatList1 = (List<DailyStatUiModel>.of([])).obs;
  RxList<DailyStatUiModel> dailyStatList2 = (List<DailyStatUiModel>.of([])).obs;
  RxList<DailyStatUiModel> dailyStatList3 = (List<DailyStatUiModel>.of([])).obs;

  RxBool displayNextWeekBtn = false.obs;

  //mock stat data is set to positive number, so the max value is initialize as negative
  int maxSection1 = -1;
  int maxSection2 = -1;
  int maxSection3 = -1;


  DateTime currentDate = DateTime.now();

  @override
  void onInit() {
    setCurrentWeek();
    super.onInit();
  }

  void resetMaxValue() {
    maxSection1 = -1;
    maxSection2 = -1;
    maxSection3 = -1;
  }

  void setCurrentWeek() async {
    selectedDate = DateTime.now();
    currentWeek.value = getWeekDisplayDate1(selectedDate);

  }

  void setPreviousWeek() {
    selectedDate = selectedDate.subtract(Duration(days: 6));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);

  }

  void setNextWeek() {
    selectedDate = selectedDate.add(Duration(days: 6));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);

  }

  void setNextWeekButtonVisibility() {
    displayNextWeekBtn.value = !selectedDate.isSameDate(currentDate);
  }
  String getWeekDisplayDate1(DateTime dateTime) {

    DateTime startDate = dateTime.subtract(Duration(days: 6));

    String formattedStartDate = DateFormat('dd MMM').format(startDate);
    String formattedEndDate = DateFormat('dd MMM').format(dateTime);
    print("selected_getWeekDisplayDate ${formattedStartDate} ${formattedEndDate}");
    return '${formattedStartDate} - ${formattedEndDate}';
  }
  String getWeekDisplayDate(DateTime dateTime) {

    DateTime endDate = dateTime.add(Duration(days: 6));

    String formattedStartDate = DateFormat('dd MMM').format(dateTime);
    String formattedEndDate = DateFormat('dd MMM').format(endDate);
    print("selected_getWeekDisplayDate ${formattedStartDate} ${formattedEndDate}");
    return '${formattedStartDate} - ${formattedEndDate}';
  }


  Future<void> getDailyStatList(DateTime dateTime) async {
    resetMaxValue();
    var daysInWeek = AppDateUtils.getDaysInWeek(dateTime);

    List<DailyStatUiModel> section1Stat = List.filled(7, defaultDailyStat);
    List<DailyStatUiModel> section2Stat = List.filled(7, defaultDailyStat);
    List<DailyStatUiModel> section3Stat = List.filled(7, defaultDailyStat);

    var today = DateTime.now();
    var todayPosition = DateTime.now().weekday - 1;

    for (var i = 0; i <= 6; i++) {
      var date = daysInWeek[i];
      var randomStat1 = randomInt(100);
      section1Stat[i] = DailyStatUiModel(
          day: date.toFormatString('EEE'),
          stat: randomStat1
          );

      if (maxSection1 < randomStat1) {
        maxSection1 = randomStat1;
      }

      var randomStat2 = randomInt(100);
      section2Stat[i] = DailyStatUiModel(
          day: date.toFormatString('EEE'),
          stat: randomStat2
         );

      if (maxSection2 < randomStat1) {
        maxSection2 = randomStat2;
      }

      var randomStat3 = randomInt(100);
      section3Stat[i] = DailyStatUiModel(
          day: date.toFormatString('EEE'),
          stat: randomStat3,
         );

      if (maxSection3 < randomStat1) {
        maxSection3 = randomStat3;
      }

      dailyStatList1.assignAll(section1Stat);
      dailyStatList2.assignAll(section2Stat);
      dailyStatList3.assignAll(section3Stat);
    }
  }

  int randomInt(int max) {
    return Random().nextInt(100) + 1;
  }

  void setSelectedDayPosition(int position, int sectionNumber) {
    switch (sectionNumber) {
      case 1:
        {

          break;
        }
      case 2:
        {

          break;
        }
      case 3:
        {

          break;
        }
    }
  }



  double getStatPercentage(int time, int type) {
    switch (type) {
      case 1:
        {
          return getSection1StatPercentage(time);
        }
      case 2:
        {
          return getSection2StatPercentage(time);
        }
      case 3:
        {
          return getSection3StatPercentage(time);
        }
      default:
        return 0.0;
    }
  }

  double getSection3StatPercentage(int time) {
    if (time == 0) {
      return 0;
    } else {
      return time / maxSection3;
    }
  }

  double getSection2StatPercentage(int time) {
    if (time == 0) {
      return 0;
    } else {
      return time / maxSection2;
    }
  }

  double getSection1StatPercentage(int time) {
    if (time == 0) {
      return 0;
    } else {
      return time / maxSection1;
    }
  }

  void onNextWeek() {
    setNextWeek();
  }

  void onPreviousWeek() {
    setPreviousWeek();
  }
}
