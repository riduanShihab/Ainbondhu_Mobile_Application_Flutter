import 'package:ain_bondhu_app/screens/lawyer_search_screen.dart';
import 'package:get/get.dart';
import '../controllers/payment_controller.dart';
import '../controllers/professional_profile_controller.dart';
import '../controllers/settings_controller.dart';
import '../screens/appointment_detail_screen.dart';
import '../screens/lawyer_main_profile_screen.dart';
import '../screens/lawyer_profile_screen.dart';
import '../screens/payment_history.dart';
import '../screens/professional_profile_screen.dart';
import '../screens/profile_edit_screen.dart';
import '../screens/requested_appointment_details.dart';
import '../screens/service_detail_screen.dart';
import '../screens/service_booking_screen.dart';
import '../screens/chat_detail_screen.dart';
import '../screens/chat_list_screen.dart';
import '../screens/consultation_screen.dart';
import '../screens/requested_appointments_screen.dart';
import '../screens/search_service_screen.dart';
import '../screens/service_list_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/intro_screen.dart';
import '../screens/auth_selection_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../settings/notification_settings_screen.dart';
import '../settings/privacy_settings_screen.dart';
import '../settings/settings_screen.dart';
import '../widgets/main_wrapper.dart';
import '../screens/lawyer_my_services_screen.dart';
import '../screens/lawyer_service_requests_screen.dart';
import '../screens/lawyer_service_details_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String intro = '/intro';
  static const String authSelection = '/auth-selection';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String lawyerSearch = '/lawyer_search';
  static const String serviceSearch = '/service-search';
  static const String consultation = '/consultation';
  static const String requestedAppointments = '/requested-appointments';
  static const String appointmentDetails = '/appointment-details';
  static const String chatList = '/chat-list';
  static const String chatDetail = '/chat-detail';
  static const String serviceDetails = '/service-details';
  static const String serviceBooking = '/service-booking';

  static const String lawyerProfile = '/lawyer-profile';
  static const String serviceList = '/service-list';
  static const String profile = '/profile';

  static const String lawyerMyServices = '/lawyer-my-services';
  static const String lawyerServiceRequests = '/lawyer-service-requests';
  static const String lawyerServiceDetails = '/lawyer-service-details';
  static const String settings = '/settings';
  static const String notificationSettings = '/notification-settings';
  static const String privacySettings = '/privacy-settings';
  static const String editProfile = '/edit-profile';
  static const String professionalProfile = '/professional-profile';
  static const String paymentHistory = '/payment-history';
  static const String requestedDetails = '/requested-details';



  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: intro, page: () => IntroScreen()),
    GetPage(name: authSelection, page: () => AuthSelectionScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signup, page: () => SignUpScreen()),
    GetPage(
      name: home,
      page: () => MainWrapper(),
      transition: Transition.fadeIn,

    ),
    GetPage(
      name: requestedDetails,
      page: () => const RequestedAppointmentDetailsScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: lawyerSearch, page: () => LawyerSearchScreen()),
    GetPage(name: serviceSearch, page: () => ServiceSearchScreen()),
    GetPage(name: consultation, page: () => ConsultationScreen()),
    GetPage(name: requestedAppointments, page: () => RequestedAppointmentsScreen()),
    GetPage(name: appointmentDetails, page: () => AppointmentDetailsScreen()),
    GetPage(name: chatList, page: () =>  ChatListScreen()),

    GetPage(
      name: chatDetail,
      page: () => ChatDetailScreen(userName: Get.arguments ?? "User"),
    ),
    GetPage(
      name: lawyerProfile,
      page: () =>  LawyerProfileScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: serviceList,
      page: () => const ServiceListScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: serviceDetails, page: () => ServiceDetailScreen()),
    GetPage(name: serviceBooking, page: () => ServiceBookingScreen()),

    GetPage(name: profile, page: () => LawyerSideProfileScreen()),

    GetPage(name: lawyerMyServices, page: () => LawyerMyServicesScreen()),
    GetPage(name: lawyerServiceRequests, page: () => LawyerServiceRequestsScreen()),
    GetPage(name: lawyerServiceDetails, page: () => LawyerServiceDetailsScreen()),
    GetPage(
      name: AppRoutes.settings,
      page: () {
        Get.put(SettingsController());
        return const SettingsScreen();
      },
    ),
    GetPage(
      name: AppRoutes.notificationSettings,
      page: () {
        Get.put(SettingsController());
        return NotificationSettingsScreen();
      },
    ),
    GetPage(
      name: AppRoutes.privacySettings,
      page: () {
        Get.put(SettingsController());
        return PrivacySettingsScreen();
      },
    ),
    GetPage(name: AppRoutes.editProfile, page: () => EditProfileScreen()),
    GetPage(
      name: AppRoutes.professionalProfile,
      page: () =>  ProfessionProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfessionProfileController>(
                () => ProfessionProfileController());
      }),

    ),
  GetPage(
  name: AppRoutes.paymentHistory,
  page: () =>  PaymentHistoryScreen(),
  binding: BindingsBuilder(() {
  Get.lazyPut<PaymentController>(
  () => PaymentController());
  }),
  ),


  ];
}