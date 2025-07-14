import 'package:aplicacion2/features/home%20page/presentation/pages/explore_page.dart';
import 'package:aplicacion2/features/home%20page/presentation/pages/home_page.dart';
import 'package:aplicacion2/features/home%20page/presentation/pages/profile_page.dart';
import 'package:aplicacion2/features/login/presentation/pages/HistorialPage.dart';
import 'package:aplicacion2/features/login/presentation/pages/PrivacyPolicyPage.dart';
import 'package:aplicacion2/features/login/presentation/pages/admin_page.dart';
import 'package:aplicacion2/features/login/presentation/pages/eventos_page.dart';
import 'package:aplicacion2/features/login/presentation/pages/previo_page.dart';
import 'package:aplicacion2/features/register/presentation/pages/register_page.dart';
import 'package:aplicacion2/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'features/login/presentation/blocs/auth_bloc.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'core/routes/domain/router_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Clean Login',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: RouterConstants.previo,
  routes: [
    GoRoute(
        path: RouterConstants.historial ,builder: (context, state) => const HistorialPage()),
    GoRoute(path: RouterConstants.profile, builder: (context, state) => const ProfilePage()),
    GoRoute(
        path: RouterConstants.privacidad,
        builder: (context, state) => const PrivacyPolicyPage()),
    GoRoute(path: RouterConstants.previo, builder: (context, state) => const PrevioPage()),
    GoRoute(path: RouterConstants.login, builder: (context, state) => const LoginPage()),
    GoRoute(
        path: RouterConstants.privacy,
        builder: (context, state) => const PrivacyPolicyPage()),
    GoRoute(path: RouterConstants.home, builder: (context, state) => const HomePage()),
    GoRoute(path: RouterConstants.eventos, builder: (context, state) => const ExplorePage()),
    GoRoute(path: RouterConstants.eventos, builder: (context, state) => const EventosPage()),
    GoRoute(path: RouterConstants.register, builder: (context, state) => const RegisterPage()),
    GoRoute(path: RouterConstants.admin, builder: (context, state) => const AdminPage()),
  ],
);
