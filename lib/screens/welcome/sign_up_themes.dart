import 'package:flutter/material.dart';
import 'package:junto_beta_mobile/app/themes_provider.dart';
import 'package:provider/provider.dart';

class SignUpThemes extends StatelessWidget {
  const SignUpThemes({
    Key key,
    @required this.toggleRainbow,
  }) : super(key: key);

  final Function toggleRainbow;

  void _setTheme(String theme, BuildContext context) {
    if (theme == 'LIGHT INDIGO') {
      Provider.of<JuntoThemesProvider>(context).setTheme('light-indigo');
    } else if (theme == 'LIGHT ROYAL') {
      Provider.of<JuntoThemesProvider>(context).setTheme('light-royal');
    } else if (theme == 'JUNTO NIGHT') {
      Provider.of<JuntoThemesProvider>(context).setTheme('night-indigo');
    }
  }

  Widget _displayThemeSelector(String theme, BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleRainbow(false);

        _setTheme(theme, context);
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(1000),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: const <double>[0.3, 0.9],
                    colors: _displayThemeSelectorGradient(theme)),
              ),
            ),
            const SizedBox(height: 15),
            Text(theme,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2)),
          ],
        ),
      ),
    );
  }

  List<Color> _displayThemeSelectorGradient(String theme) {
    if (theme == 'LIGHT INDIGO') {
      return <Color>[
        // junto purple
        const Color(0xFF635FAA),
        const Color(0xff22517D)
      ];
    } else if (theme == 'LIGHT ROYAL') {
      return <Color>[
        // junto purple
        const Color(0xFF635FAA),
        // junto gold
        const Color(0xFFF7BF47)
      ];
    } else if (theme == 'JUNTO NIGHT') {
      return <Color>[
        // junto purple
        const Color(0xFF333333),
        // junto gold
        const Color(0xff555555)
      ];
    }
    return <Color>[];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * .24,
              ),
              child: const Text(
                'Which theme feels best?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _displayThemeSelector('LIGHT INDIGO', context),
                  _displayThemeSelector('LIGHT ROYAL', context),
                  GestureDetector(
                    onTap: () {
                      toggleRainbow(true);
                      Provider.of<JuntoThemesProvider>(context)
                          .setTheme('light-indigo');
                    },
                    child: Container(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(right: 20, left: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                  'assets/images/junto-mobile__background--lotus.png',
                                  height: 65,
                                  width: 65,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'JUNTO RAINBOW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _displayThemeSelector('JUNTO NIGHT', context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
