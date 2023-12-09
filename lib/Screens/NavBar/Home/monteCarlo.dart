import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:jal_anveshak/Screens/NavBar/Home/Graph.dart';
import '../../../constants.dart';

class MonteCarlo extends StatefulWidget {
  const MonteCarlo({Key? key}) : super(key: key);

  @override
  State<MonteCarlo> createState() => _MonteCarloState();
}

class _MonteCarloState extends State<MonteCarlo> {
  final formKey = GlobalKey<FormState>();
  double deviceHeight = Constants().deviceHeight,
      deviceWidth = Constants().deviceWidth;
  TextEditingController initialInvestmentController = TextEditingController();
  TextEditingController annualContributionController = TextEditingController();
  TextEditingController meanGrowthController = TextEditingController();
  TextEditingController stdDevController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * (140 / 804),
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
                          hintText:
                              AppLocalizations.of(context)!.initialInvestment,
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
                      controller: initialInvestmentController,
                      validator: (name) {
                        if (name == null) {
                          return 'Enter investment';
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
                          hintText:
                              AppLocalizations.of(context)!.annualContribution,
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
                      controller: annualContributionController,
                      validator: (name) {
                        if (name == null) {
                          return 'Enter contribution';
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
                          hintText: AppLocalizations.of(context)!.annualGrowth,
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
                      controller: meanGrowthController,
                      validator: (name) {
                        if (name == null) {
                          return 'Enter growth';
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
                          hintText: AppLocalizations.of(context)!.fluctuation,
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
                      controller: stdDevController,
                      validator: (name) {
                        if (name == null) {
                          return 'Enter fluctuation';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                  ),
                ],
              ),
            ),
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
                      List lst = await monteCarloSimulate(
                          int.parse(initialInvestmentController.text.trim()),
                          int.parse(annualContributionController.text.trim()),
                          double.parse(meanGrowthController.text.trim()),
                          double.parse(stdDevController.text.trim()));
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
                                          "Graph of Balance vs Year",
                                          style: const TextStyle(
                                              fontFamily: "productSansReg",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                      ),
                                      GraphWidget(graphData: lst)
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

  Future<List> monteCarloSimulate(
    int? initial,
    int? annual,
    double? mean,
    double? std,
  ) async {
    List lst = [];
    var res = await http.post(
        Uri.parse(
          'https://jal_anveshak.innomer.repl.co/monte_carlo',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "num": 100,
          "years": 30,
          "initial": initial,
          "annual": annual,
          "mean": mean! / 100,
          "std": std! / 100
        }));
    debugPrint(res.body);
    Map<String, dynamic> data = jsonDecode(res.body);
    if (kDebugMode) {
      debugPrint(res.body);
      print(data);
      lst = data['results'];
    }
    return lst;
  }
}
