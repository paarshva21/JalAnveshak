import 'package:jal_anveshak/Screens/Landing/LandingPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../constants.dart';
import '../main.dart';

class SelectLanguageDropdown extends StatefulWidget {
  const SelectLanguageDropdown({super.key});

  @override
  State<SelectLanguageDropdown> createState() => _SelectLanguageDropdownState();
}

class _SelectLanguageDropdownState extends State<SelectLanguageDropdown> {
  String selectedVal = 'en';
  double deviceHeight = Constants().deviceHeight,
      deviceWidth = Constants().deviceWidth;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey[900]!,
                    Colors.black,
                    Colors.grey[900]!,
                  ]),
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.chooseLanguage,
                          style: TextStyle(
                              fontFamily: "productSansReg",
                              color: Colors.cyan[500],
                              fontWeight: FontWeight.w700,
                              fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 20 * (height / deviceHeight),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 200 * (height / deviceHeight),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ModelViewer(
                            backgroundColor: Colors.transparent,
                            src: 'assets/output_model.gltf',
                            alt: 'A 3D model of an astronaut',
                            autoRotate: true,
                            disableZoom: true,
                            autoPlay: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: DropdownButtonFormField(
                          onChanged: (v) => setState(() {
                            MainApp.setLocale(context, Locale(v.toString()));
                            selectedVal = v!;
                          }),
                          value: selectedVal,
                          items: const [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('English'),
                            ),
                            DropdownMenuItem(value: 'hi', child: Text('हिंदी')),
                            DropdownMenuItem(value: 'ar', child: Text('عربي')),
                          ],
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
                      SizedBox(
                        height: 20 * (height / deviceHeight),
                      ),
                      SizedBox(
                        width: width * (135.0 / 340),
                        height: height * (40.0 / 804),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LandingPage()));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.cyan[500],
                              ),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ))),
                          child: Text(
                            AppLocalizations.of(context)!.proceed,
                            style: const TextStyle(
                                fontFamily: "productSansReg",
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ))));
  }
}
