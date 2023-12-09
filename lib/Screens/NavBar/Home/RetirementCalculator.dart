import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jal_anveshak/Screens/NavBar/Home/getPlans.dart';
import 'package:jal_anveshak/Screens/NavBar/Home/monteCarlo.dart';
import 'package:jal_anveshak/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RetirementCalculator extends StatefulWidget {
  const RetirementCalculator(
      {Key? key, required this.name, required this.token})
      : super(key: key);
  final String name, token;

  @override
  State<RetirementCalculator> createState() => _RetirementCalculatorState();
}

class _RetirementCalculatorState extends State<RetirementCalculator> {
  final formKey = GlobalKey<FormState>();
  var selectedVal1 = "Cautious", selectedVal2 = "Like a king/queen";
  late String name;
  double deviceHeight = Constants().deviceHeight,
      deviceWidth = Constants().deviceWidth;

  @override
  void initState() {
    super.initState();
    name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  "${AppLocalizations.of(context)!.welcome}, ${widget.name}.",
                  style: TextStyle(
                      fontFamily: "productSansReg",
                      color: Colors.cyan[500],
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                        icon: const FaIcon(FontAwesomeIcons.piggyBank),
                        text: AppLocalizations.of(context)!.getPlans),
                    Tab(
                        icon: const Icon(FontAwesomeIcons.sackDollar),
                        text: AppLocalizations.of(context)!.stressTest)
                  ],
                  labelStyle: TextStyle(
                    fontFamily: "productSansReg",
                    color: Colors.cyan[500],
                    fontWeight: FontWeight.w500,
                  ),
                  indicatorColor: Colors.cyan[500],
                  dividerColor: Colors.transparent,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        getPlans(
                          name: name,
                        ),
                        const MonteCarlo()
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
