// lib/app/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:go_hrm/app/bindings/create_note_binding.dart';
import 'package:go_hrm/app/bindings/note_detail_binding.dart';

import '../bindings/activity_detail_binding.dart';
import '../bindings/album_detail_binding.dart';
import '../bindings/albums_overview_binding.dart';
import '../bindings/all_albums_binding.dart';
import '../bindings/all_media_binding.dart';
import '../bindings/appeal_binding.dart';
import '../bindings/calender_binding.dart';
import '../bindings/chat_detail_binding.dart';
import '../bindings/chats_binding.dart';
import '../bindings/create_album_binding.dart';
import '../bindings/create_appeal_request_binding.dart';
import '../bindings/create_document_request_binding.dart';
import '../bindings/create_leave_request_binding.dart';
import '../bindings/documents_binding.dart';
import '../bindings/edit_note_binding.dart';
import '../bindings/edit_profile_binding.dart';
import '../bindings/favourite_binding.dart';
import '../bindings/help_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/leave_binding.dart';
import '../bindings/login_binging.dart';
import '../bindings/meeting_detail_binding.dart';
import '../bindings/menu_binding.dart';
import '../bindings/menu_char_binding.dart';
import '../bindings/navigation_binding.dart';
import '../bindings/news_binding.dart';
import '../bindings/news_details_binding.dart';
import '../bindings/notes_binding.dart';
import '../bindings/notification_binding.dart';
import '../bindings/privacy_policy_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/quota_binding.dart';
import '../bindings/salary_binding.dart';
import '../bindings/salary_detail_binding.dart';
import '../bindings/settings_binding.dart';
import '../bindings/splash_binding.dart';
import '../bindings/timetable_binding.dart';
import '../data/models/news_card_model.dart';
import '../ui/pages/activity_detail_page/activity_detail_page.dart';
import '../ui/pages/album_detail_page/album_detail_page.dart';
import '../ui/pages/albums_overview_page/albums_overview_page.dart';
import '../ui/pages/all_albums_page/all_albums_page.dart';
import '../ui/pages/all_media_page/all_media_page.dart';
import '../ui/pages/appeal_page/appeal_page.dart';
import '../ui/pages/calender_page/calender_page.dart';
import '../ui/pages/chat_detail_page/chat_detail_page.dart';
import '../ui/pages/chats_page/chats_page.dart';
import '../ui/pages/create_ appeal_request_page/create_appeal_request_page.dart';
import '../ui/pages/create_album_page/create_album_page.dart';
import '../ui/pages/create_documents_request_page/create_documents_request_page.dart';
import '../ui/pages/create_leave_request_page/create_leave_request_page.dart';
import '../ui/pages/create_note_page/create_note_page.dart';
import '../ui/pages/edit_note_page/edit_note_page.dart';
import '../ui/pages/edit_profile_page/edit_profile_page.dart';
import '../ui/pages/document_page/document_page.dart';
import '../ui/pages/favourite_page/favourite_page.dart';
import '../ui/pages/help_page/help_page.dart';
import '../ui/pages/home_page/home_page.dart';
import '../ui/pages/leave_page.dart/leave_page.dart';
import '../ui/pages/login_page/login_page.dart';
import '../ui/pages/meeting_detail_page/meeting_detail_page.dart';
import '../ui/pages/menu_chat-page/menu_chat_page.dart';
import '../ui/pages/menu_page/menu_page.dart';
import '../ui/pages/navigation_page/navigation_page.dart';
import '../ui/pages/news_details_page/news_details_page.dart';
import '../ui/pages/news_page/news_page.dart';
import '../ui/pages/note_detail_page/note_detail_page.dart';
import '../ui/pages/notes_page/notes_page.dart';
import '../ui/pages/notification_page/notification_page.dart';
import '../ui/pages/privacy_policy_page/privacy_policy_page.dart';
import '../ui/pages/profile_page/profile_page.dart';
import '../ui/pages/quota_page/quota_page.dart';
import '../ui/pages/salary_detail_page/salary_detail_page.dart';
import '../ui/pages/salary_page/salary_page.dart';
import '../ui/pages/settings_page/settings_page.dart';
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

    GetPage(
      name: AppRoutes.NEWS_DETAILS,
      page: () {
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
    GetPage(
      name: AppRoutes.FAVOURITE_SETTINGS,
      page: () => FavouritePage(),
      binding: FavouriteBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.APPEAL,
      page: () => AppealPage(),
      binding: AppealBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CREATE_APPEAL_REQUEST,
      page: () => CreateAppealRequestPage(),
      binding: CreateAppealRequestBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CREATE_DOCUMENT_REQUEST,
      page: () => CreateDocumentsRequestPage(),
      binding: CreateDocumentRequestBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SALARYDETAIL,
      page: () => SalaryDetailPage(),
      binding: SalaryDetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.PRIVACY_POLICY,
      page: () => PrivacyPolicyPage(),
      binding: PrivacyPolicyBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.HELP,
      page: () => HelpPage(),
      binding: HelpBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => SettingsPage(),
      binding: SettingsBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE,
      page: () => EditprofilePage(),
      binding: EditprofileBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CHAT_DETAIL,
      page: () => ChatDetailPage(),
      binding: ChatDetailBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.MENU_CHAT,
      page: () => MenuChatPage(),
      binding: MenuCharBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.ALL_MEDIA,
      page: () => const AllAlbumsPage(), // [แก้ไข] เปลี่ยนเป็น ALL_ALBUMS
      binding: AllAlbumsBinding(), // [แก้ไข] ใช้ AllAlbumsBinding
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.ALL_ALBUMS,
      page: () => const AllAlbumsPage(),
      binding: AllAlbumsBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.ALBUMS_OVERVIEW,
      page: () => const AlbumsOverviewPage(),
      binding: AlbumsOverviewBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.NOTES, 
      page: () => const NotesPage(),
      binding: NotesBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.CREATE_NOTE, 
      page: () => const CreateNotePage(),
      binding: CreateNoteBinding(), 
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.EDIT_NOTE, // [เพิ่ม] GetPage สำหรับแก้ไขโน้ต
      page: () => EditNotePage(),
      binding: EditNoteBinding(),
    ),
    GetPage(
      name: AppRoutes.NOTE_DETAIL, // เส้นทางใหม่
      page: () => NoteDetailPage(), // หน้าใหม่
      binding: NoteDetailBinding(), 
       transition: _defaultTransition,
    ),
    GetPage( // [เพิ่ม] GetPage สำหรับ CREATE_ALBUM
      name: AppRoutes.CREATE_ALBUM,
      page: () => const CreateAlbumPage(),
      binding: CreateAlbumBinding(),
      transition: _defaultTransition,
    ),
    GetPage(
      name: AppRoutes.ALBUM_DETAIL,
      page: () => const AlbumDetailPage(),
      binding: AlbumDetailBinding(),
      transition: _defaultTransition,
    ),
  ];
}