import 'package:intl/intl.dart';

String formatVnIntString(String value) {
  final number = int.tryParse(value.replaceAll('.', '')) ?? 0;
  final formatter = NumberFormat('#,###', 'vi_VN');
  return formatter.format(number);
}
