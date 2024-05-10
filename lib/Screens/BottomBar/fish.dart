import 'package:flutter/material.dart';
import 'package:jal_anveshak/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FishPage extends StatefulWidget {
  const FishPage({super.key});

  @override
  State<FishPage> createState() => _FishPageState();
}

class _FishPageState extends State<FishPage> {
  String selectedVal = 'en';
  double deviceHeight = Constants().deviceHeight,
      deviceWidth = Constants().deviceWidth;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: DropdownButtonFormField(
              onChanged: (v) => setState(() {
                selectedVal = v!;
              }),
              value: selectedVal,
              items: const [
                DropdownMenuItem(
                  value: 'en',
                  child: Text('Pomfret'),
                ),
                DropdownMenuItem(value: 'hi', child: Text('Bombay duck')),
                DropdownMenuItem(value: 'ar', child: Text('Surmai')),
                DropdownMenuItem(value: 'al', child: Text('Bangda')),
                DropdownMenuItem(value: 'ai', child: Text('Bhetki')),
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
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.cyan[500],
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
        ],
      ),
    );
  }
}
