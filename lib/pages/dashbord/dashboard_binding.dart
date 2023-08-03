import 'package:community_app/data/repositories/deshboard_Repository.dart';
import 'package:community_app/data/repositories/events_repository.dart';
import 'package:community_app/data/repositories/message_repository.dart';
import 'package:community_app/data/repositories/news_repository.dart';
import 'package:community_app/pages/dashbord/dashboard_controller.dart';
import 'package:get/get.dart';

import '../../data/repositories/account_setting_Repository.dart';
import '../../data/services/api_service.dart';
import '../account_setting_Page/account_setting_controller.dart';
import '../home_page/homepage_controller.dart';
import '../member_page/member_controller.dart';
import '../message_page/message_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController(),
        fenix: true);
    Get.lazyPut<HomePageController>(
        () => HomePageController(
              newsRepository: NewsRepository(
                apiService: ApiService(),
              ),
              eventsRepository: EventsRepository(
                apiService: ApiService(),
              ),
            ),
        fenix: true);
    Get.lazyPut<MemberController>(
        () => MemberController(
              deshboardRepository: DeshboardRepository(
                apiService: ApiService(),
              ),
              messageRepository: MessageRepository(
                apiService: ApiService(),
              ),
            ),
        fenix: true);
    Get.lazyPut<MessageController>(
        () => MessageController(
              deshboardRepository: DeshboardRepository(
                apiService: ApiService(),
              ),
              messageRepository: MessageRepository(
                apiService: ApiService(),
              ),
            ),
        fenix: true);
    Get.lazyPut<AccountsettingController>(
        () => AccountsettingController(
              accountSettingRepository: AccountSettingRepository(
                apiService: ApiService(),
              ),
            ),
        fenix: true);
  }
}
