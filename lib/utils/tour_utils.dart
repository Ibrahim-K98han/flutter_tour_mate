import 'package:intl/intl.dart';

String getFormatedDate(int date, String format)=>
    DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(
        date));