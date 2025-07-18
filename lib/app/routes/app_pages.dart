import 'package:get/get.dart';

import '../bindings/activity_detail_binding.dart';
import '../bindings/calender_binding.dart';
import '../bindings/chats_binding.dart';
import '../bindings/create_document_request_binding.dart';
import '../bindings/create_leave_request_binding.dart';
import '../bindings/documents_binding.dart';
import '../bindings/favourite_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/leave_binding.dart';
import '../bindings/login_binging.dart';
import '../bindings/meeting_detail_binding.dart';
import '../bindings/menu_binding.dart';
import '../bindings/navigation_binding.dart';
import '../bindings/news_binding.dart';
import '../bindings/news_details_binding.dart';
import '../bindings/notification_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/quota_binding.dart';
import '../bindings/salary_binding.dart';
import '../bindings/salary_detail_binding.dart';
import '../bindings/splash_binding.dart';
import '../bindings/timetable_binding.dart';
import '../data/models/news_card_model.dart';
import '../ui/pages/activity_detail_page/activity_detail_page.dart';
import '../ui/pages/calender_page/calender_page.dart';
import '../ui/pages/chats_page/chats_page.dart';
import '../ui/pages/create_documents_request_page/create_documents_request_page.dart';
import '../ui/pages/create_leave_request_page/create_leave_request_page.dart';
import '../ui/pages/document_page.dart/document_page.dart';
import '../ui/pages/favourite_page/favourite_page.dart';
import '../ui/pages/home_page/home_page.dart';
import '../ui/pages/leave_page.dart/leave_page.dart';
import '../ui/pages/login_page/login_page.dart';
import '../ui/pages/meeting_detail_page/meeting_detail_page.dart';
import '../ui/pages/menu_page/menu_page.dart';
import '../ui/pages/navigation_page/navigation_page.dart';
import '../ui/pages/news_details_page/news_details_page.dart';
import '../ui/pages/news_page/news_page.dart';
import '../ui/pages/notification_page/notification_page.dart';
import '../ui/pages/profile_page/profile_page.dart';
import '../ui/pages/quota_page/quota_page.dart';
import '../ui/pages/salary_detail_page/salary_dedail_page.dart';
import '../ui/pages/salary_page/salary_page.dart';
import '../ui/pages/splash_page/splash_page.dart';
import '../ui/pages/timetable_page/timetable_page.dart';
import '../ui/pages/unknown_route_page/unknown_route_page.dart';
import 'app_routes.dart';

final _defaultTransition = Transition.native;

class AppPages {
  static final unknownRoutePage = GetPage(
    name: AppRoutes.UNKNOWN,
    page: () => UnknownRoutePage(),
    transition: _defaultTransition,
  );

  static final List<GetPage> pages = [
    unknownRoutePage,
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinging(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.NAVIGATION,
      page: () => const NavigationPage(),
      binding: NavigationBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.NEWS,
      page: () => NewsPage(),
      binding: NewsBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CHATS,
      page: () => ChatsPage(),
      binding: ChatsBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CALENDER,
      page: () => CalenderPage(),
      binding: CalenderBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MENU,
      page: () => MenuPage(),
      binding: MenuBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.NOTIFICATION,
      page: () => NotificationPage(),
      binding: NotificationBinding(),
      transition: _defaultTransition,
    ),

    // GetPage(
    //   name: AppRoutes.NEWS_DETAILS,
    //   page: () => NewsDetailsPage(),
    //   binding: NewsDetailsBinding(),
    //   transition: _defaultTransition,
    // ),
    GetPage(
      name: AppRoutes.NEWS_DETAILS,
      page: () {
        // <--- แก้ไขตรงนี้: ดึง arguments แล้วส่งไปให้ NewsDetailsPage
        final NewsCardModel news = Get.arguments as NewsCardModel;
        
        return NewsDetailsPage(news: news);
      },
      binding: NewsDetailsBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.LEAVE,
      page: () => LeavePage(),
      binding: LeavePageBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CREATE_LEAVE_REQUEST,
      page: () => const CreateLeaveRequestPage(),
      binding: CreateLeaveRequestBinding(),
    ),
    GetPage(
      name: AppRoutes.QUOTA,
      page: () => const QuotaPage(),
      binding: QuotaBinding(),
    ),
    GetPage(
      name: AppRoutes.TIMETABLE,
      page: () => TimetablePage(),
      binding: TimetableBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.ACTIVITYDETAIL,
      page: () => ActivityDetailPage(),
      binding: ActivitydetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MEETINGDETAIL,
      page: () => MeetingDetailPage(),
      binding: MeetingDetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SALARY,
      page: () => SalaryPage(),
      binding: SalaryBinding(),
      transition: _defaultTransition,
    ),
     GetPage(
       name: AppRoutes.DOCUMENTS,
       page: () => DocumentsPage(),
       binding: DocumentsBinding(),
       transition: _defaultTransition,
     ),
     GetPage(
       name: AppRoutes.CREATE_DOCUMENT_REQUEST,
       page: () => CreateDocumentsRequestPage(),
       binding: CreateDocumentRequestBinding(),
       transition: _defaultTransition,
     ),
     GetPage( // <-- เพิ่ม GetPage ใหม่นี้
       name: AppRoutes.FAVOURITE_SETTINGS,
       page: () => FavouritePage(),
       binding: FavouriteBinding(),
       transition: _defaultTransition,
     ),
    GetPage(
      name: AppRoutes.DOCUMENTS,
      page: () => DocumentsPage(),
      binding: DocumentsBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CREATE_DOCUMENT_REQUEST,
      page: () => CreateDocumentsRequestPage(),
      binding: CreateDocumentRequestBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SALARYDEtAIL,
      page: () => SalaryDetailPage(),
      binding: SalaryDetailBinding(),
      transition: _defaultTransition,
    ),
  ];
}
