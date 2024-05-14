import 'package:intl/intl.dart';

String formatDateBydMMMYYYY(DateTime dateTime) =>
    DateFormat('d MMM, yyyy').format(dateTime);
