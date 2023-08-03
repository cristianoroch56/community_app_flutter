import 'package:community_app/pages/add_members/add_members_binding.dart';
import 'package:community_app/pages/add_members/add_members_page.dart';
import 'package:community_app/pages/auth/forget_password/forget_password_page.dart';
import 'package:community_app/pages/auth/otp/otp_page.dart';
import 'package:community_app/pages/auth/register/register_page.dart';
import 'package:community_app/pages/auth/reset_password/reset_password_page.dart';
import 'package:community_app/pages/chat_page/chat_page.dart';
import 'package:community_app/pages/dashbord/dashbord_page.dart';
import 'package:community_app/pages/event_details/event_details_page.dart';
import 'package:community_app/pages/help_and_support/help_and_support_page.dart';
import 'package:community_app/pages/home_page/home_page.dart';
import 'package:community_app/pages/home_page/homepage_binding.dart';
import 'package:community_app/pages/language_page/language_binding.dart';
import 'package:community_app/pages/latest_events/latest_events_page.dart';
import 'package:community_app/pages/latest_news/latest_news_binding.dart';
import 'package:community_app/pages/latest_news/latest_news_page.dart';
import 'package:community_app/pages/member_page/member_page.dart';
import 'package:community_app/pages/members_profile/members_profile.dart';
import 'package:community_app/pages/message_page/message_page.dart';
import 'package:community_app/pages/news_details/news_details_page.dart';
import 'package:community_app/pages/no_internet/no_internet_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../pages/auth/forget_password/forget_password_binding.dart';
import '../pages/auth/login/login_binding.dart';
import '../pages/auth/login/login_page.dart';
import '../pages/auth/otp/otp_binding.dart';
import '../pages/auth/register/register_binding.dart';
import '../pages/auth/reset_password/reset_password_binding.dart';
import '../pages/chat_page/chat_page_binding.dart';
import '../pages/dashbord/dashboard_binding.dart';
import '../pages/event_details/event_details_binding.dart';
import '../pages/help_and_support/help_and_support_binding.dart';
import '../pages/language_page/language_page.dart';
import '../pages/latest_events/latest_events_binding.dart';
import '../pages/member_page/member_binding.dart';
import '../pages/members_profile/members_profile_binding.dart';
import '../pages/message_page/message_binding.dart';
import '../pages/my_members/my_members_page.dart';
import '../pages/my_members/my_members_binding.dart';
import '../pages/my_profile/my_profile.dart';
import '../pages/my_profile/my_profile_binding.dart';
import '../pages/news_details/news_details_binding.dart';
import '../pages/no_internet/no_internet_binding.dart';
import '../pages/notification_page/notification_binding.dart';
import '../pages/notification_page/notification_page.dart';
import '../pages/onboarding_page/onboarding_binding.dart';
import '../pages/onboarding_page/onboarding_page.dart';
import '../pages/account_setting_Page/account_setting_binding.dart';
import '../pages/account_setting_Page/account_setting_page.dart';
import '../pages/splash_screen.dart';
import 'app_routes.dart';

final routePages = [
  GetPage(
    name: root,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: ROUTE_ONBOARDING_PAGE,
    page: () => const OnBoardingPage(),
    binding: OnBoardingBinding(),
  ),
  GetPage(
    name: ROUTE_LANGUAGE_PAGE,
    page: () => const LanguagePage(),
    binding: LanguageBinding(),
  ),
  GetPage(
    name: ROUTE_LOGIN_PAGE,
    page: () => const LoginPage(),
    binding: LoginBinding(),
  ),
  GetPage(
      name: ROUTE_FORGET_PASSWORD_PAGE,
      page: () => const ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_RESETPASSWORD_PAGE,
      page: () => const ResetPasswordPage(mobileNumber: ""),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_OTP_PAGE,
      page: () => const OtpPage(mobileNumber: "", isRegistrationFlow: false),
      binding: OtpBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_REGITSER_PAGE,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft),
  GetPage(
    name: ROUTE_DASHBOARD_PAGE,
    page: () => const DashbordPage(),
    binding: DashboardBinding(),
  ),
  GetPage(
    name: ROUTE_HOME_PAGE,
    page: () => const Homepage(),
    binding: HomePageBinding(),
  ),
  GetPage(
    name: ROUTE_MEMBERS_PAGE,
    page: () => const Memberpage(),
    binding: MemberBinding(),
  ),
  GetPage(
    name: ROUTE_MESSAGE_PAGE,
    page: () => const Messagepage(),
    binding: MessageBinding(),
  ),
  GetPage(
    name: ROUTE_ACCOUNTSETTNG_PAGE,
    page: () => const AccountsettingPage(),
    binding: AccountsettingBinding(),
  ),
  GetPage(
      name: ROUTE_MYPROFILE_PAGE,
      page: () => const MyProfile(),
      binding: MyprofileBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_MYMEMBERS_PAGE,
      page: () => const Memberspage(),
      binding: MymembersBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_LATESTNEWS_PAGE,
      page: () => const LatestNewsPage(),
      binding: LatestNewsBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_NEWSDETAIL_PAGE,
      page: () => const NewsDetailsPage(),
      binding: NewsDetailsBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_LATESTEVENTS_PAGE,
      page: () => const LatestEventsPage(),
      binding: LatestEventsBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_EVENTDETAILS_PAGE,
      page: () => const EventDetailsPage(),
      binding: EventDetailsBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_ADDMEMBERS_PAGE,
      page: () => const AddMembersPage(),
      binding: AddMembersBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_MEMBERSPROFILE_PAGE,
      page: () => const MembersProfilePage(),
      binding: MembersProfileBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_NOTIFICATION_PAGE,
      page: () => const NotificationPage(),
      binding: NotificationBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: ROUTE_HELPANDSUPPORT_PAGE,
      page: () => const HelpAndSupportPage(),
      binding: HelpAndSupportBinding(),
      transition: Transition.rightToLeft),
  GetPage(
    name: ROUTE_NOINTERNET_PAGE,
    page: () => const NoInternetPage(),
    binding: NoInternetBinding(),
  ),
  GetPage(
      name: ROUTE_CHAT_PAGE,
      page: () => const ChatPage(),
      binding: ChatPageBinding(),
      transition: Transition.rightToLeft),
];
