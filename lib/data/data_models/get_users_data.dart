
import '../models/user/glehiha_user_info.dart';

class GetUsersData {
  List<GlehihaUserInfo>? glehihaUsers;
  int currentPage = 0;
  int lastPage = 0;
  int total = 0;

  GetUsersData({this.glehihaUsers});

  GetUsersData.fromMap(Map<String, dynamic> json) {
    glehihaUsers = <GlehihaUserInfo>[];
    currentPage = json["current_page"] ?? 0;
    lastPage = json["last_page"] ?? 0;
    total = json["total"] ?? 0;
    for (var item in json["data"]) {
      glehihaUsers?.add(GlehihaUserInfo.fromMap(item));
    }
  }
}
