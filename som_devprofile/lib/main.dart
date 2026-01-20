import 'package:flutter/material.dart';
import 'app.dart';
import 'splashscreen.dart';
import 'src/configure_web.dart';
import 'src/json_service.dart';
import 'theme/config.dart';
import 'theme/material_theme.dart';
import 'common/util.dart';

void main() {
  configureApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  bool _splashDone = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(_onThemeChanged);
    jsonService.addListener(_onDataLoaded);
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    
    _initializeApp();
  }

  void _onThemeChanged() {
    if (mounted) setState(() {});
  }

  void _onDataLoaded() {
    if (mounted) setState(() {});
  }

  Future<void> _initializeApp() async {
    await jsonService.init();
    // Start splash timer once init complete - extended duration for better UX
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() => _splashDone = true);
        _fadeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    currentTheme.removeListener(_onThemeChanged);
    jsonService.removeListener(_onDataLoaded);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget app = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Som Subhra Pandit - Portfolio',
      theme: (const MaterialTheme(TextTheme()).light()),
      darkTheme: (const MaterialTheme(TextTheme()).dark()),
      themeMode: currentTheme.currentTheme,
      home: const App(),
      builder: (context, child) {
        final themedChild = Theme(
          data: Theme.of(context).copyWith(
            textTheme:
                createTextTheme(context, "Source Code Pro", "Ubuntu Condensed"),
          ),
          child: child!,
        );
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.2),
            ),
          ),
          child: themedChild,
        );
      },
    );

    // Show splash until both data is loaded and splash finished
    if (JSONService.hasLoaded && _splashDone) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: app,
      );
    }

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


