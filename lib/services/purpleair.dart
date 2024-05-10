import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PurpleAir {
  // Purple Air
  static const purpleAirUrl = 'https://api.purpleair.com/';
  static const purpleAirApiAuthUrl = 'v1/keys';
  static const purpleAirApiSensorDataUrl = 'v1/sensors';
  static const sensorIdxMortise = '157049';

  Future<int> getAuth(String apiKey) async {
    const url = purpleAirUrl + purpleAirApiAuthUrl;

    // Add custom headers
    var headers = {
      'X-API-KEY': apiKey,
    };
    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    print(response);

    if (response.statusCode == 201) {
      final sp = await SharedPreferences.getInstance();
      await sp.setString('purpleAirKey', apiKey);
      return response.statusCode;
    } else {
      return 401;
    }
  }

  // example of how to get the data from purpleair
  Future<Map<String, dynamic>> getData() async {
    final sp = await SharedPreferences.getInstance();
    final xApiKey = sp.getString('purpleAirKey');

    if (xApiKey != null) {
      const url =
          purpleAirUrl + purpleAirApiSensorDataUrl + '/' + sensorIdxMortise;
      // Add custom headers
      var headers = {
        'X-API-KEY': xApiKey,
      };
      //Get the response
      print('Calling: $url');
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response);

      if (response.statusCode == 201) {
        final decodedResponse = jsonDecode(response.body);
        return decodedResponse;
      } else {
        return {};
      }
    }
    return {};
  }

  Future<Map<String, dynamic>> getHistoryData(DateTime startTime) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final xApiKey = sp.getString('purpleAirKey');
      final url =
          '$purpleAirUrl$purpleAirApiSensorDataUrl/$sensorIdxMortise/history/?start_timestamp=${startTime.millisecondsSinceEpoch / 1000}&end_timestamp=${startTime.add(const Duration(days: 1)).millisecondsSinceEpoch / 1000}&fields=pm2.5_atm';
      // Add custom headers
      var headers = {
        'X-API-KEY': xApiKey!,
      };
      //Get the response
      print('Calling: $url');
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return decodedResponse;
      } else {
        print('Error in purpleair call');
        return {};
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
