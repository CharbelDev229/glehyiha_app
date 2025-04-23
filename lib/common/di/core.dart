import 'package:glehiha/common/helpers/request_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/instances.dart';

class DiCore {
  static Future<void> dependencies() async {
    prefs = await SharedPreferences.getInstance();
    Get.lazyPut(() => DioRequestManager(dio: Dio()), fenix: true);
    Get.lazyPut(() => http.Client(), fenix: true);
    Get.lazyPut(() => HttpRequestManager(Get.find()), fenix: true);
  }
}
