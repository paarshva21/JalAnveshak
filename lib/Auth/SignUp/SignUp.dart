import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jal_anveshak/Models/SignUpModel.dart';
import 'package:jal_anveshak/Models/Utils.dart';
import 'package:jal_anveshak/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String email1 = "", password1 = "", password2 = "";
  final String url = Constants().url;

  bool hidden1 = true;
  bool hidden2 = true;
  File? image;
  String? name, gender;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
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
                  body: GestureDetector(
                      onTap: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: SingleChildScrollView(
                          child: Center(
                        child: Column(children: [
                          SizedBox(
                            width: width * (20 / 340),
                            height: height * (30.0 / 804),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 300.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back_sharp),
                                color: Colors.cyan[500],
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(20.0)),
                          Container(
                            padding: const EdgeInsets.only(top: 80),
                            child: Text(
                              AppLocalizations.of(context)!.signup,
                              style: TextStyle(
                                  color: Colors.cyan[500],
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "productSansReg"),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(20.0)),
                          Container(
                              padding: const EdgeInsets.only(
                                  left: 35.0, right: 35.0),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(13),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .firstName,
                                            hintStyle: const TextStyle(
                                                fontFamily: "productSansReg",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                            errorStyle: const TextStyle(
                                                fontFamily: "productSansReg",
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide.none)),
                                        controller: firstNameController,
                                        validator: (name) {
                                          if (name == null) {
                                            return 'Enter your first name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {},
                                      ),
                                    ),
                                    const Padding(padding: EdgeInsets.all(5.0)),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(13),
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .lastName,
                                            hintStyle: const TextStyle(
                                                fontFamily: "productSansReg",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                            errorStyle: const TextStyle(
                                                fontFamily: "productSansReg",
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                borderSide: BorderSide.none)),
                                        controller: lastNameController,
                                        validator: (name) {
                                          if (name == null) {
                                            return 'Enter your last name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {},
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(padding: EdgeInsets.all(10.0)),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(13),
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText:
                                          AppLocalizations.of(context)!.email,
                                      hintStyle: const TextStyle(
                                          fontFamily: "productSansReg",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      errorStyle: const TextStyle(
                                          fontFamily: "productSansReg",
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide.none)),
                                  controller: emailController,
                                  validator: (email) {
                                    if (email != null &&
                                        !EmailValidator.validate(email)) {
                                      return 'Please enter a Valid Email';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    email1 = value!;
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(10.0)),
                                TextFormField(
                                  obscureText: hidden1,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText:
                                        AppLocalizations.of(context)!.password,
                                    hintStyle: const TextStyle(
                                        fontFamily: "productSansReg",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    errorStyle: const TextStyle(
                                        fontFamily: "productSansReg",
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                    suffix: InkWell(
                                        onTap: () {
                                          setState(() {
                                            hidden1 = !hidden1;
                                          });
                                        },
                                        child: Icon(
                                          !hidden1
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 20,
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        borderSide: BorderSide.none),
                                  ),
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Password';
                                    } else if (value.length < 8) {
                                      return "Enter minimum eight characters";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    password1 = value!;
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(10.0)),
                                TextFormField(
                                  obscureText: hidden2,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(10),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: AppLocalizations.of(context)!
                                        .confirmPassword,
                                    hintStyle: const TextStyle(
                                        fontFamily: "productSansReg",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    errorStyle: const TextStyle(
                                        fontFamily: "productSansReg",
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500),
                                    suffix: InkWell(
                                        onTap: () {
                                          setState(() {
                                            hidden2 = !hidden2;
                                          });
                                        },
                                        child: Icon(
                                          !hidden2
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 20,
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        borderSide: BorderSide.none),
                                  ),
                                  onSaved: (value) {
                                    password2 = value!;
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm password';
                                    }
                                    if (password1.trim() != password2.trim()) {
                                      return "Password doesn't match Confirm Password";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  width: width * (20 / 340),
                                  height: height * (50.0 / 804),
                                ),
                                SizedBox(
                                    width: width * (135 / 340),
                                    height: height * (40 / 804),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.cyan[500]),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                          ))),
                                      onPressed: () async {
                                        _formKey.currentState!.save();
                                        if (_formKey.currentState!.validate()) {
                                          if (password1 == password2) {
                                            List<dynamic> lst = await signUp(
                                                emailController.text.trim(),
                                                passwordController.text.trim(),
                                                "${firstNameController.text.trim()} ${lastNameController.text.trim()}");
                                            print(lst);
                                            print(lst[0]);
                                            if (lst[3] == null) {
                                              Utils.showSnackBar(lst[3]);
                                            } else {
                                              Utils.showSnackBar1(lst[1]);
                                              Navigator.of(context).pop();
                                            }
                                          }
                                        }
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.signup,
                                        style: const TextStyle(
                                          fontFamily: "productSansReg",
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                              ]))
                        ]),
                      )))),
            ),
          ),
        ));
  }

  Future<List<dynamic>> signUp(String? email, String? password, String? name) async {
    var res = await http.post(
      Uri.parse('https://retiral.vercel.app/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "email": "$email",
        "password": "$password",
        "name": "$name",
        "role": "user"
      }),
    );
    Map<String, dynamic> data = jsonDecode(res.body);
    if (kDebugMode) {
      debugPrint(res.body);
      print(data);
    }
    var response = SignUpModel.fromJson(data);
    var list = [
      response.success,
      response.message,
      response.user?.name,
      response.error
    ];
    if (kDebugMode) {
      print(list);
    }
    return list;
  }
}
