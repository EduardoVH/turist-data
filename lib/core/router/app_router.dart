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
import '../../features/establecimiento/presentation/pages/establecimiento.dart';
import 'package:turist_data/features/establecimiento/presentation/blocs/establecimiento_bloc.dart';
import 'package:turist_data/features/establecimiento/presentation/blocs/establecimiento_event.dart';
import 'package:turist_data/features/estadistica/presentation/pages/estadisticas.dart';
import 'package:turist_data/features/comentary/presentation/pages/comentary.dart';
import 'package:turist_data/features/events/presentation/bloc/eventos_bloc.dart';
import 'package:turist_data/features/chatbot/presentation/pages/chatbot_page.dart'; // OJO: sin 'hide'
import 'package:turist_data/features/chatbot/presentation/pages/chat_welcome_page.dart';

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
        builder: (context, state) => BlocProvider(
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
        builder: (context, state) => BlocProvider(
          create: (_) => sl<EventosBloc>()..add(LoadEventosEspeciales()),
          child: const EventsPage(),
        ),
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
<<<<<<< HEAD
        path: RouterConstants.chat,
        builder: (context, state) => const ChatBotPage(),
      ),
=======
        path: RouterConstants.establecimiento,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<EstablecimientoBloc>()..add(LoadEstablecimientos()),
          child: const EstablecimientoHomePage(),
        ),
      ),
      GoRoute(
        path: RouterConstants.estadisticas,
        builder: (context, state) => const EstadisticasPage(),
      ),
      GoRoute(
        path: RouterConstants.comentarios,
        builder: (context, state) => const CommentPage(),
      ),

      // Ruta para la página de bienvenida al chat
      GoRoute(
        path: RouterConstants.chatWelcome,
        builder: (context, state) => ChatWelcomePage(
          sugerencias: [
            '¿Qué lugares turísticos hay cerca?',
            '¿Recomiéndame un restaurante local?',
            '¿Qué eventos hay hoy?',
          ],
        ),
      ),

      // Ruta para el chat, recibe pregunta opcional por query param
      GoRoute(
        path: '/chat',
        builder: (context, state) {
          final pregunta = state.uri.queryParameters['pregunta'];
          return ChatBotPage(preguntaInicial: pregunta);
        },
      ),

>>>>>>> 2a8a2670ed3cd7a96ed935c3658cab3e8347b3a2
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
  static const String chat = '/chat';
  static const String chatWelcome = '/chat-welcome';
  static const String establecimiento = '/establecimiento';
  static const String estadisticas = '/estadisticas';
  static const String comentarios = '/comentarios';
}
