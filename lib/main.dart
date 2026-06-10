import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/remote/nasa_api_service.dart';
import 'data/repository/space_weather_repository_impl.dart';
import 'domain/model/space_weather_event.dart';
import 'domain/usecase/get_events_usecase.dart';
import 'firebase_options.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/screens.dart';
import 'presentation/viewmodel/space_weather_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final repository = SpaceWeatherRepositoryImpl(NasaApiService());
  runApp(SolarShieldApp(repository: repository));
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const HomeScreen();
        }

        return const LoginScreen();
      },
    );
  }
}

class SolarShieldApp extends StatelessWidget {
  final SpaceWeatherRepositoryImpl repository;
  const SolarShieldApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpaceWeatherViewModel(GetEventsUseCase(repository), repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Solar Shield',
        theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (_) => const AuthGate(),
          '/home': (_) => const HomeScreen(),
          '/login': (_) => const LoginScreen(),
          '/events': (_) => const EventsScreen(),
          '/favorites': (_) => const FavoritesScreen(),
          '/about': (_) => const AboutScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/details') {
            final event = settings.arguments as SpaceWeatherEvent;
            return MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: Text(event.id)), body: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(event.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text('Início: ${event.startTime}'), Text('Kp: ${event.kp}'), Text('Risco: ${event.severity}'), Text('Notificação emergencial: ${event.emergencyNotification ? 'SIM' : 'NÃO'}'), const SizedBox(height: 8), Text(event.link)]))));
          }
          return null;
        },
      ),
    );
  }
}
