import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mealmatch/screen/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mealmatch/services/data_manager.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Naver Map SDK
  await NaverMapSdk.instance.initialize(
      clientId: 'nyzcf5qljz',
      onAuthFailed: (ex) {
        print("****네이버맵 인증오류: $ex ****");
      });

  // Initialize Firebase if not already initialized
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (e is! FirebaseException || e.code != 'duplicate-app') {
      rethrow;
    }
  }

  // DataManager 인스턴스 가져오기 및 초기화
  DataManager dataManager = DataManager();
  dataManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataManager>(
      create: (context) => DataManager(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LoginSignUpScreen(), // Assuming this is your initial screen
      ),
    );
  }
}
