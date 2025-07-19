import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turist_data/core/di/injection.dart';
import 'package:turist_data/features/chatbot/presentation/pages/chatbot_page.dart';
import 'package:turist_data/features/register/presentation/blocs/register_bloc.dart';
import 'package:turist_data/features/register/presentation/pages/register_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/admin/presentation/pages/admin_page.dart';
import '../../features/events/presentation/pages/events_page.dart';
import '../../features/explore/presentation/pages/explore_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/privacy_policy/presentation/pages/privacy_policy_page.dart';
import '../../features/preview/presentation/pages/preview_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

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
        builder:(context, state) => BlocProvider(
          create: (context) => sl<RegisterBloc>(),
          child: const RegisterPage(),
        ),
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
      GoRoute(
        path: RouterConstants.chat,
        builder: (context, state) => const ChatBotPage(),
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
