import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mealmatch/screen/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
=======
  await NaverMapSdk.instance.initialize(
      clientId: 'nyzcf5qljz',
      onAuthFailed: (ex) {
        print("****네이버맵 인증오류: $ex ****");
        /*
      * 401
      * 잘못된 클라이언트 ID 지정
      * 잘못된 클라이언트 유형 사용
      * 콘손에 등록된 앱 패키지 이름과 미일치
      * 429
      * 콘솔에서 Maps 서비스를 선택하지 않음
      * 사용 한도 초과
      * 800
      * 클라이언트 ID 미지정
      * */
      });

  WidgetsFlutterBinding.ensureInitialized();
>>>>>>> dev_my
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginSignUpScreen(),
    );
  }
}
