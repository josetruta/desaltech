import "package:desaltech_app/models/desaltech_instance.dart";
import 'package:intl/intl.dart';

class AllInstances {
  const AllInstances({
    required this.listInstances
  });

  final List<DesalTechInstance> listInstances;

  int _weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }
  
  int _currentWeek() {
    final currentDate = DateTime.now();
    final firstJan = DateTime(currentDate.year, 1, 1);

    return _weeksBetween(firstJan, currentDate);
  }

  List currentInstancesWeekly() {
    return listInstances.where((DesalTechInstance instance) =>
      instance.weekOfInstance == _currentWeek()
    ).toList();
  }

  List currentInstancesDaily() {
    return listInstances.where((DesalTechInstance instance) =>
      instance.weekOfInstance == _currentWeek() && 
      instance.weekdayOfInstance == DateFormat('EEEE').format(DateTime.now())
    ).toList();
  }
}