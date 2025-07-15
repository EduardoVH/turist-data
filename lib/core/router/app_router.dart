import 'package:go_router/go_router.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/register_page.dart';
import '../../presentation/pages/admin_page.dart';
import '../../presentation/pages/events_page.dart';
import '../../presentation/pages/explore_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/history_page.dart';
import '../../presentation/pages/privacy_policy_page.dart';
import '../../presentation/pages/preview_page.dart';
import '../../presentation/pages/profile_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouterConstants.previo,
    routes: [
      GoRoute(
        path: RouterConstants.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouterConstants.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: RouterConstants.admin,
        builder: (context, state) => const AdminPage(),
      ),
      GoRoute(
        path: RouterConstants.eventos,
        builder: (context, state) => const EventsPage(),
      ),
      GoRoute(
        path: RouterConstants.explore,
        builder: (context, state) => const ExplorePage(),
      ),
      GoRoute(
        path: RouterConstants.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RouterConstants.historial,
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: RouterConstants.privacidad,
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: RouterConstants.privacy,
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: RouterConstants.previo,
        builder: (context, state) => const PreviewPage(),
      ),
      GoRoute(
        path: RouterConstants.profile,
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}

class RouterConstants {
  static const String login = '/';
  static const String register = '/register';
  static const String admin = '/admin';
  static const String eventos = '/eventos';
  static const String explore = '/explore';
  static const String home = '/home';
  static const String privacidad = '/privacidad';
  static const String privacy = '/privacy';
  static const String previo = '/previo';
  static const String profile = '/profile';
  static const String historial = '/historial';
  static const String chat = '/chat'; // pendiente
}
