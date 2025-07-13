import 'package:get/get.dart';

import '../modules/about_app/bindings/about_app_binding.dart';
import '../modules/about_app/views/about_app_view.dart';
import '../modules/aktivitas/bindings/aktivitas_binding.dart';
import '../modules/aktivitas/views/aktivitas_view.dart';
import '../modules/analisis/bindings/analisis_binding.dart';
import '../modules/analisis/views/analisis_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/event/bindings/event_binding.dart';
import '../modules/event/views/detail_event_view.dart';
import '../modules/event/views/event_view.dart';
import '../modules/favorit/bindings/favorit_binding.dart';
import '../modules/favorit/views/favorit_view.dart';
import '../modules/galery/bindings/galery_binding.dart';
import '../modules/galery/views/galery_view.dart';
import '../modules/galery/views/gallery_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/informasi/bindings/informasi_binding.dart';
import '../modules/informasi/views/informasi_view.dart';
import '../modules/jejak/bindings/jejak_binding.dart';
import '../modules/jejak/views/jejak_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/maintenance/bindings/maintenance_binding.dart';
import '../modules/maintenance/views/maintenance_view.dart';
import '../modules/mapping/bindings/mapping_binding.dart';
import '../modules/mapping/views/mapping_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/otp_verification/bindings/otp_verification_binding.dart';
import '../modules/otp_verification/views/otp_verification_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_question_view.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/controllers/new_password_controller.dart';
import '../modules/reset_password/controllers/reset_otp_verification_controller.dart';
import '../modules/reset_password/views/reset_new_password_view.dart';
import '../modules/reset_password/views/reset_otp_verification_view.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/riwayat/bindings/riwayat_binding.dart';
import '../modules/riwayat/views/riwayat_view.dart';
import '../modules/riwayat_login/bindings/riwayat_login_binding.dart';
import '../modules/riwayat_login/views/riwayat_login_view.dart';
import '../modules/scan_page/bindings/scna_page_binding.dart';
import '../modules/scan_page/views/scna_page_view.dart';
import '../modules/security/bindings/security_binding.dart';
import '../modules/security/views/security_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/intro_view_view.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/video/bindings/video_binding.dart';
import '../modules/video/views/video_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.GALERY,
      page: () => GalleryView(),
      binding: GaleryBinding(),
    ),
    GetPage(
      name: '/gallery-detail',
      page: () => const GalleryDetailView(),
    ),
    GetPage(
      name: _Paths.SCNA_PAGE,
      page: () => const ScnaPageView(),
      binding: ScnaPageBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: '/reset/verify',
      page: () => const ResetOtpVerificationView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ResetOtpVerificationController());
      }),
    ),
    GetPage(
      name: '/reset/new-password',
      page: () => const NewPasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => NewPasswordController());
      }),
    ),

    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.SECURITY,
      page: () => SecurityView(),
      binding: SecurityBinding(),
    ),
    GetPage(
      name: _Paths.EVENT,
      page: () => const EventView(),
      binding: EventBinding(),
    ),
    GetPage(
      name: '/event-detail',
      page: () => const DetailEventView(),
    ),
    GetPage(
      name: _Paths.JEJAK,
      page: () => const JejakView(),
      binding: JejakBinding(),
    ),
    // app_pages.dart
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: '/quiz-question',
      page: () => QuizQuestionView(),
    ),

    GetPage(
      name: _Paths.AKTIVITAS,
      page: () => const AktivitasView(),
      binding: AktivitasBinding(),
    ),
    GetPage(
      name: _Paths.INFORMASI,
      page: () => const InformasiView(),
      binding: InformasiBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_APP,
      page: () => const AboutAppView(),
      binding: AboutAppBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.MAINTENANCE,
      page: () => const MaintenanceView(),
      binding: MaintenanceBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFICATION,
      page: () => const OtpVerificationView(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashOneView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: '/splash-two',
      page: () => const SplashTwoView(),
    ),
    GetPage(
      name: _Paths.MAPPING,
      page: () => MappingView(),
      binding: MappingBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => const RiwayatView(),
      binding: RiwayatBinding(),
    ),
    GetPage(
      name: _Paths.FAVORIT,
      page: () => const FavoritView(),
      binding: FavoritBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_LOGIN,
      page: () => const RiwayatLoginView(),
      binding: RiwayatLoginBinding(),
    ),
    GetPage(
      name: _Paths.ANALISIS,
      page: () => const AnalisisView(),
      binding: AnalisisBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO,
      page: () => const VideoView(),
      binding: VideoBinding(),
    ),
  ];
}
