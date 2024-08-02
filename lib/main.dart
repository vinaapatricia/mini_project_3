import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_3/bloc/profile_bloc/profile_bloc.dart';
import 'package:mini_project_3/firebase_options.dart';
import 'package:mini_project_3/helper/firebase_notification_helper.dart';
import 'package:mini_project_3/screens/auth_screen/sign_in.dart';
import 'package:mini_project_3/screens/auth_screen/sign_up.dart';
import 'package:mini_project_3/screens/auth_screen/splash_screen.dart';
import 'package:mini_project_3/screens/cart_screen/cart_pages.dart';
import 'package:mini_project_3/screens/home_page.dart';
import 'package:mini_project_3/screens/product_screen/list_product.dart';
import 'package:mini_project_3/screens/profile_screen/profile_screen.dart';
import 'package:mini_project_3/services/profile_repository.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  await Firebase_Notification().initNotifications();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final List<Widget> _pages = [
    ProductPages(),
    CartPages(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProfileBloc(ProfileRepository())..add(LoadProfileEvent()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        initialRoute: '/main',
        routes: {
          '/productPages': (context) => ProductPages(),
          '/': (context) => SplashScreen(),
          '/signup': (context) => SignUpPages(),
          '/signin': (context) => SignInPages(),
          '/home': (context) => HomePages(),
          '/main': (context) => const MainScreen(),
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: screenIndex,
        onTap: (value) => setState(() => screenIndex = value),
        selectedItemColor: const Color(0xff00aa5a),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
      body: MyApp._pages[screenIndex],
    );
  }
}
