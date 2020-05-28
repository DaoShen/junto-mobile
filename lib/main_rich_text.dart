import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart'
    show DeviceOrientation, SystemChrome, SystemUiOverlayStyle;
import 'package:junto_beta_mobile/app/logger/sentry.dart';
import 'package:junto_beta_mobile/app/themes_provider.dart';
import 'package:junto_beta_mobile/backend/backend.dart';
import 'package:junto_beta_mobile/widgets/rich_text_editor/rich_text_editor.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  final Backend backend = await Backend.init();
  //final bool _loggedIn = await backend.authRepo.isLoggedIn();
  runLoggedApp(
    ChangeNotifierProvider<JuntoThemesProvider>(
      create: (_) => JuntoThemesProvider(),
      child: Consumer<JuntoThemesProvider>(
        builder: (BuildContext context, JuntoThemesProvider theme, _) {
          return MaterialApp(
            theme: theme.currentTheme.copyWith(
              canvasColor: Colors.white,
            ),
            debugShowCheckedModeBanner: false,
            title: 'JUNTO Alpha',
            home: RichTextEditorExample(),
          );
        },
      ),
    ),
  );
}

class RichTextEditorExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Focus(
              onFocusChange: (bool hasFocus) {
                print('focus other $hasFocus');
              },
              child: Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () => Focus.of(context).requestFocus(),
                    child: TextField(
                      decoration: InputDecoration(
                        // fillColor: Colors.red,
                        filled: true,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: RichTextEditor(),
            ),
          ],
        ),
      ),
    );
  }
}