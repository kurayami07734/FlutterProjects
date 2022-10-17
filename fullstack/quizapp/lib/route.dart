import 'about/about_screen.dart';
import 'home/home_screen.dart';
import 'login/login_screen.dart';
import 'profile/profile_screen.dart';
import 'topics/topics_screen.dart';

final appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};
