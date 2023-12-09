import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jal_anveshak/Models/Utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecommendationCard extends StatefulWidget {
  const RecommendationCard(
      {super.key,
      required this.name,
      required this.image,
      required this.email,
      required this.color,
      required this.token});
  final String? name, image, email, token;
  final bool color;

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Card(
      color: widget.color ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      elevation: 3,
      shadowColor: Colors.blueGrey,
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 4.0, left: 8.0, right: 8.0),
              child: widget.name != null
                  ? SizedBox(
                      width: width * (100 / 340),
                      child: Text(
                        widget.name!,
                        style: TextStyle(
                            fontFamily: "productSansReg",
                            color:
                                widget.color ? Colors.cyan[500] : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    )
                  : SizedBox(
                      width: width * (100 / 340),
                      child: Text(
                        "Firstname Lastname",
                        style: TextStyle(
                            fontFamily: "productSansReg",
                            color:
                                widget.color ? Colors.cyan[500] : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
            ),
            if (!widget.color)
              Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 8.0, left: 8.0, right: 8.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.cyan[500]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ))),
                      onPressed: () async {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: SizedBox(
                                  height: 500 * (height / 804),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SizedBox(
                                              child: TextFormField(
                                            controller: controller,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                filled: true,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .connect,
                                                hintStyle: const TextStyle(
                                                    fontSize: 17.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        "productSansReg"),
                                                suffix: InkWell(
                                                  onTap: () async {
                                                    bool x = await forumInvite(
                                                        widget.email,
                                                        "Invite to Retiral Forum",
                                                        controller.text.trim(),
                                                        widget.token);
                                                    Navigator.of(context).pop();
                                                    Utils.showSnackBar1(
                                                        "Email sent!");
                                                    if (x == true) {
                                                      Utils.showSnackBar1(
                                                          "Email sent!");
                                                    } else {
                                                      Utils.showSnackBar(
                                                          "Error occurred!");
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.send_rounded,
                                                    size: 25,
                                                  ),
                                                ),
                                                fillColor: Colors.white),
                                          )),
                                        ),
                                        widget.image != null
                                            ? Image.network(widget.image!)
                                            : Image.asset(
                                                "assets/images/new_profile.png"),
                                        Text(
                                          widget.name != null
                                              ? widget.name!
                                              : "Firstname Lastname",
                                          style: const TextStyle(
                                              fontFamily: "productSansReg",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          widget.email != null
                                              ? widget.email!
                                              : "stock@email.com",
                                          style: const TextStyle(
                                              fontFamily: "productSansReg",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text(
                        AppLocalizations.of(context)!.knowMore,
                        style: const TextStyle(
                            fontFamily: "productSansReg",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      )))
          ],
        ),
      ),
    );
  }

  Future<bool> forumInvite(
      String? email, String? subject, String? message, String? token) async {
    if (kDebugMode) {
      print(token);
    }
    var res = await http.post(
      Uri.parse('https://retiral.vercel.app/api/send-invite-email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': "$token"
      },
      body: jsonEncode(<String, dynamic>{
        "emails": ["$email"],
        "subject": "$subject",
        "message": "$message",
      }),
    );
    debugPrint(res.body);
    Map<String, dynamic> data = jsonDecode(res.body);
    if (kDebugMode) {
      debugPrint(res.body);
      print(data);
    }
    return data['success'];
  }
}
