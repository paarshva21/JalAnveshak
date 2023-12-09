import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import '../../../Models/RetirementAdviceModel.dart';
import '../../../constants.dart';

class getPlans extends StatefulWidget {
  const getPlans({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<getPlans> createState() => _getPlansState();
}

class _getPlansState extends State<getPlans> {
  final formKey = GlobalKey<FormState>();
  var selectedVal1 = "Cautious", selectedVal2 = "Like a king/queen";
  double deviceHeight = Constants().deviceHeight,
      deviceWidth = Constants().deviceWidth;
  TextEditingController currentAgeController = TextEditingController();
  TextEditingController retirementAgeController = TextEditingController();
  TextEditingController workExpController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController inflationRateController = TextEditingController();
  TextEditingController dependentsController = TextEditingController();
  TextEditingController netWorthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(13),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppLocalizations.of(context)!.currentAge,
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
              padding: const EdgeInsets.all(10.0),
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(13),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: AppLocalizations.of(context)!.inflationRate,
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
                      controller: inflationRateController,
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
                          hintText: AppLocalizations.of(context)!.dependents,
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
                      controller: dependentsController,
                      validator: (name) {
                        if (name == null) {
                          return 'Enter dependants';
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
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(13),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: AppLocalizations.of(context)!.worthOfAssets,
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: "productSansReg"),
                    errorStyle: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontFamily: "productSansReg"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide.none)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  if (email == null) {
                    return 'Enter net worth';
                  }
                  return null;
                },
                controller: netWorthController,
                onSaved: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButtonFormField(
                hint: Text(
                  AppLocalizations.of(context)!.safetyInRetirement,
                  style: const TextStyle(
                      fontFamily: "productSansReg",
                      color: Colors.black,
                      fontSize: 17),
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
                    child: Text(AppLocalizations.of(context)!.middleOfTheRoad),
                  ),
                  DropdownMenuItem(
                      value: 'Daring',
                      child: Text(AppLocalizations.of(context)!.daring)),
                ],
                style: const TextStyle(
                    fontFamily: "productSansReg",
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
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
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  hint: Text(
                    AppLocalizations.of(context)!.typeOfRetirement,
                    style: const TextStyle(
                        fontFamily: "productSansReg",
                        color: Colors.black,
                        fontSize: 17),
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
                        child:
                            Text(AppLocalizations.of(context)!.iAmHappyWayIam)),
                    DropdownMenuItem(
                        value: 'Like a monk',
                        child: Text(AppLocalizations.of(context)!.likeAMonk)),
                  ],
                  style: const TextStyle(
                      fontFamily: "productSansReg",
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(13),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none)),
                )),
            const Padding(padding: EdgeInsets.all(7.0)),
            SizedBox(
                width: width * (135 / 340),
                height: height * (40 / 804),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.cyan[500],
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ))),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      List lst = await retirementAdvice(
                          int.parse(currentAgeController.text.trim()),
                          int.parse(retirementAgeController.text.trim()),
                          int.parse(workExpController.text.trim()),
                          int.parse(salaryController.text.trim()),
                          int.parse(inflationRateController.text.trim()),
                          int.parse(dependentsController.text.trim()),
                          int.parse(netWorthController.text.trim()),
                          selectedVal1,
                          selectedVal2);
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.blueGrey[400]!,
                                        Colors.white,
                                      ]),
                                ),
                                height: 500 * (height / 804),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Investment required: ${lst[2].toString()}",
                                          style: const TextStyle(
                                              fontFamily: "productSansReg",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Returns expected: ${lst[3].toString()}",
                                          style: const TextStyle(
                                              fontFamily: "productSansReg",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Time period: ${lst[1].toString()}",
                                          style: const TextStyle(
                                              fontFamily: "productSansReg",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          lst[0],
                                          style: const TextStyle(
                                              fontFamily: "productSansReg",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.enter,
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
    );
  }

  Future<List> retirementAdvice(
      int? current,
      int? retire,
      int? workExp,
      int? salary,
      int? inflation,
      int? dependants,
      int? netWorth,
      String? safety,
      String? type) async {
    var res = await http.get(
      Uri.https('tiaa.innomer.repl.co', '/retirement-calculator', {
        "salary": salary.toString(),
        "current_age": current.toString(),
        "goalRetirementAge": retire.toString(),
        "workExperience": workExp.toString(),
        "safetyInRetirement": safety!,
        "typeOfRetirement": type!,
        "inflation_rate": inflation.toString(),
        "currentNetWorth": netWorth.toString(),
        "noOfDependents": dependants.toString()
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    debugPrint(res.body);
    Map<String, dynamic> data = jsonDecode(res.body);
    if (kDebugMode) {
      debugPrint(res.body);
      print(data);
    }
    var response = RetirementAdviceModel.fromJson(data);
    var list = [
      response.plan,
      response.time,
      response.investment,
      response.returns,
    ];
    return list;
  }
}
