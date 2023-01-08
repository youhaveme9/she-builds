import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:prega/pages/home.dart';
// import 'package:prega/pages/signin_page.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:prega/provider/google_signin.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

Future main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: (MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Home(),
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            // textTheme: GoogleFonts.poppinsTextTheme()),
          ),
        )),
      );
}
