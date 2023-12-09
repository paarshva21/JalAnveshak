import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jal_anveshak/Screens/NavBar/Recommendations/GaugeCard.dart';
import 'package:jal_anveshak/Screens/NavBar/Recommendations/RecommendationCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math;

class Recommendations extends StatefulWidget {
  const Recommendations({Key? key, required this.userId, required this.token})
      : super(key: key);
  final String userId, token;

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  int selectedIndex = 0;
  List<int> scores = [math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
    math.Random().nextInt(50) + 50,
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
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
        ),
        Padding(
          padding: EdgeInsets.only(top: height / 2.7),
          child: Container(
            width: width,
            height: height/2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueGrey[400]!,
                    Colors.white,
                  ]),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 4, right: 4, bottom: 4),
              child: FutureBuilder<List<List<String?>>>(
                future: getUserInfo(widget.userId),
                builder: (context, snapshot) {
                  return snapshot.data != null
                      ? SingleChildScrollView(
                          child: Column(children: [
                            SizedBox(
                              height: 20 * (height / 804),
                            ),
                            for (int index = 0;
                                index < snapshot.data!.length;
                                index++)
                              GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: selectedIndex == index
                                      ? RecommendationCard(
                                          color: false,
                                          name: snapshot.data![index][2],
                                          email: snapshot.data![index][1],
                                          image: snapshot.data![index][0],
                                          token: widget.token,
                                        )
                                      : RecommendationCard(
                                          color: true,
                                          name: snapshot.data![index][2],
                                          email: snapshot.data![index][1],
                                          image: snapshot.data![index][0],
                                          token: widget.token,
                                        ))
                          ]),
                        )
                      : const Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * (50 / 840),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.meetLikeMindedPeople,
                    style: TextStyle(
                        fontFamily: "productSansReg",
                        color: Colors.cyan[500],
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                GaugueCard(
                  score: scores[selectedIndex],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<List<String?>>> getUserInfo(String userID) async {
    List<String> list1 = [];
    String url =
        "https://tiaa.innomer.repl.co/update-and-get-clusters?user_id=$userID";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (kDebugMode) {
      print(response.body);
    }
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (kDebugMode) {
          print(data["forum"]);
        }
        for (String t in data["forum"]) {
          list1.add(t);
        }
      } else {
        if (kDebugMode) {
          print(response.statusCode);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    List<List<String?>> returnList = [];
    for (String userID in list1) {
      List<String?> list = [];
      http.Response response = await http.get(
        Uri.parse("https://tiaa.innomer.repl.co/get-info?user_id=$userID"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      try {
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print(response.body);
          }
          var data = jsonDecode(response.body);
          list = [
            data["info"][0]["image"],
            data["info"][0]["email"],
            data["info"][0]["name"],
          ];
          returnList.add(list);
        } else {
          if (kDebugMode) {
            print(response.statusCode);
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
    if (kDebugMode) {
      print(returnList);
    }
    return returnList;
  }
}
