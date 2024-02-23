import 'package:intl/intl.dart';

class DesalTechInstance {
  const DesalTechInstance({
    required this.datetimeOfInstance,
    required this.temperatura,
    required this.isReservatorioCheio,
    required this.isTanqueDestiladoCheio,
    required this.correnteEletrica,
    required this.radiacaoSolar
  });

  final DateTime datetimeOfInstance;
  final double temperatura;
  final bool isReservatorioCheio;
  final bool isTanqueDestiladoCheio;
  final double correnteEletrica;
  final double radiacaoSolar;

  get weekdayOfInstance {
    return DateFormat('EEEE').format(datetimeOfInstance);
  }

  int _weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }
  
  get weekOfInstance {
    final dateOfInstance = datetimeOfInstance;
    final firstJan = DateTime(dateOfInstance.year, 1, 1);

    return _weeksBetween(firstJan, dateOfInstance);
  }


  get monthOfInstance {
    return datetimeOfInstance.month;
  }
}
