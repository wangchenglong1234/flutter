import 'package:app_inspection_system/constant/constant.dart';

class ServiceUrl {
  ///用户的仓库 get
  static userRepos(userName, sort) {
    sort ??= 'pushed';
    return "${Constant.baseUrl}users/$userName/repos?sort=$sort";
  }
}
