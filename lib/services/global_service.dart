import 'package:amster_app/services/local_storage_service.dart';
import 'package:amster_app/utils/logger.dart';



class GlobalService with LoggerMixin {
  GlobalService._internal();

  static GlobalService to = GlobalService._internal();

  @override
  String get tag => 'Global Service';

  loadLocalDatas() async {
    await LocalStorage().getBool("SAFEMODE_KEY") ?? false;
  }



}
