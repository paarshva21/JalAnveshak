import 'dart:convert';
import 'package:local_auth/local_auth.dart';
import 'package:jal_anveshak/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jal_anveshak/Auth/SignUp/ForgotPassword.dart';
import 'package:jal_anveshak/Auth/Signup/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:jal_anveshak/Models/LogInModel.dart';
import 'package:jal_anveshak/Models/Utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Screens/UserPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final LocalAuthentication auth;
  bool _supportState = false;
  final String url = Constants().url;
  String email = "", password = "";
  bool hidden = true;
  String? name;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Form(
        key: formKey,
        child: SafeArea(
          bottom: false,
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
                  child: Column(children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Text(
                          AppLocalizations.of(context)!.retiral,
                          style: TextStyle(
                              color: Colors.cyan[500],
                              fontSize: 50.0,
                              fontWeight: FontWeight.w700,
                              fontFamily: "productSansReg"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.loginCatchphrase,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "productSansReg"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(60.0)),
                    Container(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(13),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: AppLocalizations.of(context)!.email,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) {
                                if (email != null &&
                                    !EmailValidator.validate(email)) {
                                  return 'Please enter a Valid Email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              onSaved: (value) {
                                email = value!;
                              },
                            ),
                            const Padding(padding: EdgeInsets.all(10.0)),
                            TextFormField(
                              obscureText: hidden,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontFamily: "productSansReg"),
                                errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "productSansReg"),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      hidden = !hidden;
                                    });
                                  },
                                  child: Icon(
                                    !hidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: 20,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide.none),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                } else if (value.length < 8) {
                                  return "Enter minimum eight characters";
                                }
                                return null;
                              },
                              controller: _passwordController,
                              onSaved: (value) {
                                password = value!;
                              },
                            ),
                            SizedBox(
                              width: width * (20 / 340),
                              height: height * (30.0 / 804),
                            ),
                            SizedBox(
                                width: width * (135.0 / 340),
                                height: height * (40.0 / 804),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.cyan[500],
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ))),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      // List lst = await LoginGetTokens(
                                      //     _emailController.text.trim(),
                                      //     _passwordController.text.trim());
                                      if (true) {
                                        if (_supportState) {
                                          bool? finger =
                                              await _fingerprintAuthenticate(
                                                  context);
                                          if (finger!) {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setBool(
                                                'isLoggedIn', true);
                                            await prefs.setString('name', "");
                                            await prefs.setString('token', "");
                                            await prefs.setString('userId', "");
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const UserPage(
                                                            token: "",
                                                            name: "",
                                                            userId: "")));
                                          }
                                        } else {
                                          Utils.showSnackBar(
                                              AppLocalizations.of(context)!
                                                  .fingerprintAuthMessage);
                                        }
                                      } else {
                                        Utils.showSnackBar("Error occurred!");
                                      }
                                    }
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontFamily: "productSansReg"),
                                  ),
                                )),
                            SizedBox(
                              width: width * (20 / 340),
                              height: height * (30.0 / 804),
                            ),
                            GestureDetector(
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "productSansReg"),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassWord()));
                              },
                            ),
                            SizedBox(
                              width: width * (20 / 340),
                              height: height * (150.0 / 804),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: AppLocalizations.of(context)!.madeAnAcc,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "productSansReg"),
                                  children: [
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SignUp()));
                                          },
                                        text:
                                            " ${AppLocalizations.of(context)!.forSignUp}",
                                        style: TextStyle(
                                            fontFamily: "productSansReg",
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.cyan[500]!))
                                  ]),
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  Future<List> LoginGetTokens(String? email, String? password) async {
    var res = await http.post(
      Uri.parse('https://retiral.vercel.app/api/app-login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"email": "$email", "password": "$password"}),
    );
    debugPrint(res.body);
    Map<String, dynamic> data = jsonDecode(res.body);
    if (kDebugMode) {
      debugPrint(res.body);
      print(data);
    }
    var response = LogInModel.fromJson(data);
    var list = [
      response.success,
      response.message,
      response.name,
      response.token,
      response.error,
      response.userId
    ];
    return list;
  }

  Future<bool?> _fingerprintAuthenticate(BuildContext context) async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: AppLocalizations.of(context)!.toMaintainPrivacy,
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      debugPrint("Authenticated: $authenticated");
      return authenticated;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
