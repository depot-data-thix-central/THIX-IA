import 'package:intl/intl.dart';

/// Formateurs de dates pour l'interface.
class DateFormatter {
  DateFormatter._();

  static final DateFormat _timeOnly = DateFormat.Hm(); // 14:35
  static final DateFormat _dateShort = DateFormat('dd/MM/yy'); // 25/12/25
  static final DateFormat _dateLong = DateFormat('EEEE d MMMM yyyy', 'fr_FR'); // mercredi 25 décembre 2025
  static final DateFormat _dateTimeShort = DateFormat('dd/MM/yy à HH:mm');
  static final DateFormat _relativeToday = DateFormat("'Aujourd’hui à' HH:mm");
  static final DateFormat _relativeYesterday = DateFormat("'Hier à' HH:mm");

  /// Formate l'heure seule.
  static String time(DateTime date) => _timeOnly.format(date);

  /// Formate une date courte.
  static String shortDate(DateTime date) => _dateShort.format(date);

  /// Formate une date longue (en français).
  static String longDate(DateTime date) => _dateLong.format(date);

  /// Formate date + heure.
  static String dateTime(DateTime date) => _dateTimeShort.format(date);

  /// Formate un timestamp d'une conversation de manière intelligente :
  /// - Aujourd'hui → "Aujourd'hui à 14:35"
  /// - Hier → "Hier à 09:12"
  /// - Cette semaine → jour + heure (ex: "lun. 14:35")
  /// - Sinon → date courte + heure.
  static String smartDateTime(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDay = DateTime(date.year, date.month, date.day);

    if (messageDay == today) {
      return "Aujourd'hui à ${time(date)}";
    } else if (messageDay == yesterday) {
      return "Hier à ${time(date)}";
    } else if (date.isAfter(today.subtract(const Duration(days: 7)))) {
      // Cette semaine : affiche le jour abrégé + heure
      return '${DateFormat('EEE', 'fr_FR').format(date)}. ${time(date)}';
    } else {
      return dateTime(date);
    }
  }
}
