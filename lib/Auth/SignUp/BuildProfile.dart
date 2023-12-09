import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jal_anveshak/Screens/UserPage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Models/BuildProfileModel.dart';

class BuildProfile extends StatefulWidget {
  const BuildProfile(
      {Key? key, required this.token, required this.name, required this.userId})
      : super(key: key);
  final String token, name, userId;

  @override
  State<BuildProfile> createState() => _BuildProfileState();
}

class _BuildProfileState extends State<BuildProfile> {
  final formKey = GlobalKey<FormState>();
  var selectedVal1 = "Like a king/queen", selectedVal2 = "Cautious";
  TextEditingController currentAgeController = TextEditingController();
  TextEditingController retirementAgeController = TextEditingController();
  TextEditingController workExpController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  YoutubePlayerController youtubeController1 = YoutubePlayerController(
      initialVideoId: 'rdX_fkFFBok',
      flags: const YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: false,
          showLiveFullscreenButton: false));
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              AppLocalizations.of(context)!.buildProfile,
              style: TextStyle(
                  fontFamily: "productSansReg",
                  color: Colors.cyan[500],
                  fontWeight: FontWeight.w700),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * (100 / 804),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: YoutubePlayer(
                    controller: youtubeController1,
                    showVideoProgressIndicator: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(13),
                              fillColor: Colors.white,
                              filled: true,
                              hintText:
                                  AppLocalizations.of(context)!.currentAge,
                              hintStyle: const TextStyle(
                                  fontFamily: "productSansReg",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              errorStyle: const TextStyle(
                                  fontFamily: "productSansReg",
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none)),
                          controller: currentAgeController,
                          validator: (name) {
                            if (name == null) {
                              return 'Enter current age';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(5.0)),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(13),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.retireAge,
                              hintStyle: const TextStyle(
                                  fontFamily: "productSansReg",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              errorStyle: const TextStyle(
                                  fontFamily: "productSansReg",
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none)),
                          controller: retirementAgeController,
                          validator: (name) {
                            if (name == null) {
                              return 'Enter retirement age';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(13),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.workExp,
                              hintStyle: const TextStyle(
                                  fontFamily: "productSansReg",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              errorStyle: const TextStyle(
                                  fontFamily: "productSansReg",
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none)),
                          controller: workExpController,
                          validator: (name) {
                            if (name == null) {
                              return 'Enter work experience';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(5.0)),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(13),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: AppLocalizations.of(context)!.salary,
                              hintStyle: const TextStyle(
                                  fontFamily: "productSansReg",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              errorStyle: const TextStyle(
                                  fontFamily: "productSansReg",
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.0),
                                  borderSide: BorderSide.none)),
                          controller: salaryController,
                          validator: (name) {
                            if (name == null) {
                              return 'Enter salary';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonFormField(
                    hint: Text(
                      AppLocalizations.of(context)!.safetyInRetirement,
                      style: const TextStyle(
                        fontFamily: "productSansReg",
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (v) => setState(() {
                      selectedVal1 = v!;
                    }),
                    items: [
                      DropdownMenuItem(
                        value: 'Cautious',
                        child: Text(AppLocalizations.of(context)!.cautious),
                      ),
                      DropdownMenuItem(
                        value: 'Middle-of-the-road',
                        child:
                            Text(AppLocalizations.of(context)!.middleOfTheRoad),
                      ),
                      DropdownMenuItem(
                          value: 'Daring',
                          child: Text(AppLocalizations.of(context)!.daring)),
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
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButtonFormField(
                      hint: Text(
                        AppLocalizations.of(context)!.typeOfRetirement,
                        style: const TextStyle(
                          fontFamily: "productSansReg",
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (v) => setState(() {
                        selectedVal2 = v!;
                      }),
                      items: [
                        DropdownMenuItem(
                          value: 'Like a king/queen',
                          child: Text(AppLocalizations.of(context)!.likeAKing),
                        ),
                        DropdownMenuItem(
                            value: 'I am happy the way I am',
                            child: Text(
                                AppLocalizations.of(context)!.iAmHappyWayIam)),
                        DropdownMenuItem(
                            value: 'Like a monk',
                            child:
                                Text(AppLocalizations.of(context)!.likeAMonk)),
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
                    )),
                const Padding(padding: EdgeInsets.all(10)),
                SizedBox(
                    width: width * (135 / 340),
                    height: height * (40 / 804),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.cyan[500],
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ))),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await retirementAdvice(
                              int.parse(currentAgeController.text.trim()),
                              int.parse(retirementAgeController.text.trim()),
                              int.parse(workExpController.text.trim()),
                              int.parse(salaryController.text.trim()),
                              random.nextInt(10),
                              random.nextInt(1000000) + 10000,
                              selectedVal1,
                              selectedVal2,
                              widget.token);
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserPage(
                                    token: widget.token,
                                    name: widget.name,
                                    userId: widget.userId,
                                  )));
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.proceed,
                        style: const TextStyle(
                            fontFamily: "productSansReg",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> retirementAdvice(
      int? current,
      int? retire,
      int? workExp,
      int? salary,
      int? dependants,
      int? netWorth,
      String? safety,
      String? type,
      String? token) async {
    var res = await http.post(
        Uri.parse('https://retiral.vercel.app/api/retirement-calculator'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
        body: jsonEncode(<String, String>{
          "salary": "1000.00",
          "workExperience": "3",
          "age": "5",
          "goalRetirementAge": "50",
          "safetyInRetirement": "Cautious",
          "typeOfRetirement": "Like a king/queen",
          "numberOfDependantPeople": "10",
          "totalValuationOfCurrentAssets": "269303"
        }
            // {
            //   "salary": salary.toString(),
            //   "age": current.toString(),
            //   "goalRetirementAge": retire.toString(),
            //   "workExperience": workExp.toString(),
            //   "safetyInRetirement": safety!,
            //   "typeOfRetirement": type!,
            //   "totalValuationOfCurrentAssets": netWorth.toString(),
            //   "numberOfDependantPeople": dependants.toString()
            // }
            ));
    debugPrint(res.body);
    Map<String, dynamic> data = jsonDecode(res.body);
    if (kDebugMode) {
      debugPrint(res.body);
      print(data);
    }
    var response = BuildProfileModel.fromJson(data);
    if (kDebugMode) {
      debugPrint(response.success.toString());
    }
  }
}
