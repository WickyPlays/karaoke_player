import 'package:flutter/material.dart';
import 'package:karaoke_player/cores/title/sounds.dart';
import 'package:karaoke_player/screens/player_screen.dart';
import 'package:karaoke_player/screens/title_screen.dart';
import 'package:karaoke_player/screens/settings_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'package:media_kit/media_kit.dart';
import 'package:easy_localization/easy_localization.dart';

// Route Observer Setup
final routeObserver = RouteObserver<ModalRoute>();

class RouteAwareWidget extends StatefulWidget {
  final Widget child;
  const RouteAwareWidget({super.key, required this.child});

  @override
  State<RouteAwareWidget> createState() => _RouteAwareWidgetState();
}

class _RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  ModalRoute<dynamic>? _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route = ModalRoute.of(context);
    if (_route != null) {
      routeObserver.subscribe(this, _route!);
    }
  }

  @override
  void dispose() {
    if (_route != null) {
      routeObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  void didPush() {
    if (_route?.settings.name == '/') {
      TitleSounds.playBackgroundMusic();
    }
    debugPrint('Route pushed: ${_route?.settings.name}');
  }

  @override
  void didPopNext() {
    debugPrint('Returning to route: ${_route?.settings.name}');
    if (_route?.settings.name == '/') {
      TitleSounds.playBackgroundMusic();
    }
  }

  @override
  void didPop() {
    debugPrint('Route popped: ${_route?.settings.name}');
  }

  @override
  void didPushNext() {
    debugPrint('Leaving route: ${_route?.settings.name}');
    if (_route?.settings.name == '/') {
      TitleSounds.stopBackgroundMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

void main() async {
  debugPrint("App is starting...");
  MediaKit.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow(
    WindowOptions(
      title: 'Karaoke Player',
      size: const Size(800, 600),
      minimumSize: const Size(400, 300),
    ),
    () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.maximize();
    },
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const KaraokeApp(),
    ),
  );
}

class KaraokeApp extends StatelessWidget {
  const KaraokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karaoke Player',
      navigatorObservers: [routeObserver],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (context) => const TitlePage();
            break;
          case '/player':
            builder = (context) => const PlayerScreen();
            break;
          case '/editor':
            builder = (context) => const EditorPage();
            break;
          case '/settings':
            builder = (context) => const SettingsScreen();
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (context) => RouteAwareWidget(child: builder(context)),
        );
      },
      initialRoute: '/',
    );
  }
}

class EditorPage extends StatelessWidget {
  const EditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editor')),
      body: const Center(child: Text('Editor Page')),
    );
  }
}
