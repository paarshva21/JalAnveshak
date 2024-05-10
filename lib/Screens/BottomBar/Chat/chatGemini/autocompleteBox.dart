import 'package:flutter/material.dart';
import '../../../../constants.dart';

class AutoCompleteBox extends StatefulWidget {
  const AutoCompleteBox({super.key, required this.text});
  final String text;

  @override
  State<AutoCompleteBox> createState() => _AutoCompleteBoxState();
}

class _AutoCompleteBoxState extends State<AutoCompleteBox> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = Constants().deviceHeight,
        deviceWidth = Constants().deviceWidth;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SizedBox(
        width: width * (220.0 / deviceWidth),
        height: height * (20.0 / deviceHeight),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.cyan),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ))),
          onPressed: () {},
          child: Text(
            widget.text,
            style: const TextStyle(
              fontFamily: "productSansReg",
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ));
  }
}
