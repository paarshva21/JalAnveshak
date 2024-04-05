import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool? dark;
  String selectedVal = 'en';

  @override
  void initState() {
    super.initState();
    getDark();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.setting,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.cyan,
          ),
          backgroundColor: Colors.black,
          body: FutureBuilder(
            future: getDark(),
            builder: (context, snapshot) => Column(
              children: [
                Expanded(
                  child: SettingsList(brightness: Brightness.dark, sections: [
                    SettingsSection(
                        title: Text(
                          AppLocalizations.of(context)!.language,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.cyan),
                        ),
                        tiles: <SettingsTile>[
                          SettingsTile(
                            leading: const Icon(Icons.language_outlined),
                            title: Text(
                                AppLocalizations.of(context)!.chooseLanguage),
                            onPressed: (context) {
                              showMyDialog(context);
                            },
                          ),
                        ]),
                    SettingsSection(
                        title: Text(
                          AppLocalizations.of(context)!.home,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.cyan),
                        ),
                        tiles: <SettingsTile>[
                          SettingsTile.switchTile(
                            initialValue: dark ?? false,
                            leading: const Icon(Icons.dark_mode_outlined),
                            title:
                                Text(AppLocalizations.of(context)!.darkTheme),
                            onToggle: (value) async {
                              var prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('dark', value);
                              if (kDebugMode) {
                                print(dark);
                              }
                              setState(() {
                                value
                                    ? AdaptiveTheme.of(context).setDark()
                                    : AdaptiveTheme.of(context).setLight();
                                dark = value;
                              });
                            },
                          ),
                          SettingsTile(
                            leading: const Icon(Icons.display_settings),
                            title: Text(AppLocalizations.of(context)!.display),
                          ),
                        ]),
                    SettingsSection(
                        title: Text(
                          AppLocalizations.of(context)!.privacy,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.cyan),
                        ),
                        tiles: <SettingsTile>[
                          SettingsTile(
                            leading: const Icon(Icons.privacy_tip_outlined),
                            title:
                                Text(AppLocalizations.of(context)!.permissions),
                          ),
                          SettingsTile(
                            leading: const Icon(Icons.security_outlined),
                            title: Text(AppLocalizations.of(context)!.security),
                          ),
                        ]),
                    SettingsSection(
                        title: Text(
                          AppLocalizations.of(context)!.accounts,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.cyan),
                        ),
                        tiles: <SettingsTile>[
                          SettingsTile(
                            leading: const Icon(
                                Icons.supervised_user_circle_outlined),
                            title: Text(
                                AppLocalizations.of(context)!.multipleUsers),
                          ),
                          SettingsTile(
                            leading: const Icon(Icons.feedback_outlined),
                            title: Text(AppLocalizations.of(context)!.feedback),
                          ),
                        ]),
                  ]),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> getDark() async {
    var prefs = await SharedPreferences.getInstance();
    dark = prefs.getBool('dark');
    if (kDebugMode) {
      print(dark);
    }
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(

          child: AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.chooseLanguage,
              style: TextStyle(
                fontFamily: "productSansReg",
                color: Colors.cyan[500],
                fontWeight: FontWeight.w700,
              ),
            ),
            content: DropdownButtonFormField(
              items: const [
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                DropdownMenuItem(value: 'hi', child: Text('हिंदी')),
                DropdownMenuItem(value: 'ar', child: Text('عربي')),
              ],
              onChanged: (v) => setState(() {
                MainApp.setLocale(context, Locale(v.toString()));
                selectedVal = v!;
              }),
              value: selectedVal,
              style: const TextStyle(
                  fontFamily: "productSansReg",
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(13),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide.none)),
            ),
          ),
        );
      },
    );
  }
}
