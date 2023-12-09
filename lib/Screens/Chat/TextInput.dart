import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'ChatBubble.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextInput extends StatefulWidget {
  const TextInput({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  double deviceHeight = Constants().deviceHeight,
      deviceWidth = Constants().deviceWidth;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> lst = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.resolveYourQueries,
            style: TextStyle(
                fontFamily: "productSansReg",
                color: Colors.cyan[500],
                fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.cyan[500]),
        ),
        body: Container(
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
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (lst.isEmpty)
                      SizedBox(
                        height: height * (40 / deviceHeight),
                      )
                    else
                      SizedBox(
                        height: height * (60 / deviceHeight),
                      ),
                    if (lst.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: lst.length,
                          itemBuilder: (context, index) {
                            return index % 2 == 0
                                ? ChatBubble(
                                    text: lst[index], isCurrentUser: true)
                                : ChatBubble(
                                    text: lst[index], isCurrentUser: false);
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SizedBox(
                          child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintText: AppLocalizations.of(context)!.enterText,
                            hintStyle: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.cyan[500],
                                fontFamily: "productSansReg"),
                            suffix: InkWell(
                              onTap: () async {
                                String text = _controller.text.trim();
                                lst.add(text);
                                setState(() {});
                                _controller.clear();
                                var res =
                                    await chatWithBot(widget.userId, text);
                                lst.add(res.toString());
                                setState(() {});
                              },
                              child: Icon(
                                Icons.send_rounded,
                                size: 25,
                                color: Colors.cyan[500],
                              ),
                            ),
                            fillColor: Colors.white),
                      )),
                    ),
                  ])),
        ),
      ),
    );
  }

  Future<String> chatWithBot(String? userId, String? query) async {
    var res = await http.post(
      Uri.parse('https://tiaa.innomer.repl.co/chat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "user_id": "$userId",
        "query": "$query",
        "topic": "Learning",
        "chat_id": 1
      }),
    );
    debugPrint(res.body);
    Map<String, dynamic> data = jsonDecode(res.body);
    if (kDebugMode) {
      debugPrint(res.body);
      print(data);
    }
    return data["response"];
  }
}
