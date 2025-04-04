import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class BasicRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  BasicRepo({required this.sharedPreferences, required this.apiClient});
}
