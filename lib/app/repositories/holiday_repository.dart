import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:sample_project/app/model/holiday_model.dart';


final holidaysProvider = FutureProvider<List<Holidays>>((ref) async {
  final response = await http.get(Uri.parse(
      'https://www.gov.uk/bank-holidays.json'));
  if (response.statusCode == 200) {
    final body = utf8.decode(response.bodyBytes);
    final jsonBody = json.decode(body);
    print(jsonBody);
    final englandAndWales = jsonBody['england-and-wales']['events'];
    final scotland = jsonBody['scotland']['events'];
    final northernIreland = jsonBody['northern-ireland']['events'];
    final holidays = <Holidays>[];
    holidays.add(Holidays.fromJson({
      'england-and-wales': {'events': englandAndWales},
      'scotland': {'events': scotland},
      'northern-ireland': {'events': northernIreland}
    }));
    return holidays;
  } else {
    throw Exception('Failed to load holidays');
  }
});
