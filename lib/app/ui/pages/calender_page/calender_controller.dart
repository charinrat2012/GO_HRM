import 'dart:collection';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../data/models/calender_model.dart'; 
import '../../global_widgets/datalist.dart'; 



class CalenderController extends GetxController {
  
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime?> selectedDay = Rx(null);
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  final RxList<CalenderEventModel> selectedEvents = <CalenderEventModel>[].obs; 

  
  late final LinkedHashMap<DateTime, List<CalenderEventModel>> kEvents; 

  @override
  void onInit() {
    super.onInit();
    selectedDay.value = focusedDay.value;
    _initializeEvents();
    selectedEvents.value = getEventsForDay(selectedDay.value!);
  }

  void _initializeEvents() {
    
     final events = DataList.calenderEventsData.map(
      (date, eventList) => MapEntry(
        date,
        eventList.map((eventMap) => CalenderEventModel.fromMap(date, eventMap)).toList(),
      ),
    );

    kEvents = LinkedHashMap<DateTime, List<CalenderEventModel>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(events);
  }

  

  List<CalenderEventModel> getEventsForDay(DateTime day) { 
    return kEvents[day] ?? [];
  }

  void onDaySelected(DateTime newSelectedDay, DateTime newFocusedDay) {
    if (!isSameDay(selectedDay.value, newSelectedDay)) {
      selectedDay.value = newSelectedDay;
      focusedDay.value = newFocusedDay;
      selectedEvents.value = getEventsForDay(newSelectedDay);
    }
  }

  void onFormatChanged(CalendarFormat format) {
    if (calendarFormat.value != format) {
      calendarFormat.value = format;
    }
  }

  void onPageChanged(DateTime newFocusedDay) {
    focusedDay.value = newFocusedDay;
  }
}


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}