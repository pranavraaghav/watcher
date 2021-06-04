import 'package:crosswalk/pages/sign_up.dart';
import 'package:crosswalk/pages/loading_page.dart';
import 'package:crosswalk/styling/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:crosswalk/styling/color_palettes.dart';
// import 'package:crosswalk/src/pages/authentication/sign_up_page.dart';
// import 'package:crosswalk/src/pages/home_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:crosswalk/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //ForLoading
  bool isLoading = false;

  //for auth stuff
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String errorString = '';

  // for error message if invalid emailID or password
  bool error = false;
  final _formKey = GlobalKey<FormState>();

  // Create a list of text controller and use it to retrieve the current value of the TextField.
  TextEditingController emailIDTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();

  bool _obscureText = true;
  void _onCheck(bool value) => setState(() => {_obscureText = !value});

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: verticalGradient(crosswalkBlack),
        ),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Center(
                child: SizedBox(
                    width: 240,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // TITLE
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 40.0),
                            child: Text(
                              "LOG IN",
                              style: buildRobotoTextStyle(30.0, Colors.white),
                            ),
                          ),

                          Form(
                              key: _formKey,
                              child: Column(children: [
                                buildTextField(context, "Email ID",
                                    emailIDTextController, _obscureText, true),
                                buildTextField(
                                    context,
                                    "Password",
                                    passwordTextController,
                                    _obscureText,
                                    false),
                                SizedBox(
                                  height: 5,
                                ),
                                // checkbox to show password
                                buildCheckBoxColumn(context, _obscureText,
                                    _onCheck, 'Show password'),
                              ])),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            errorString,
                            style: buildRobotoTextStyle(16, Colors.red),
                          ),
                          Container(
                            width: 175.0,
                            height: 48.0,
                            margin:
                                const EdgeInsets.only(top: 30.0, bottom: 7.50),
                            child: RaisedButton(
                              color: loginYellow,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0))),
                              textColor: Colors.white,
                              onPressed: () {
                                // Validate returns true if the form is valid, otherwise false.
                                if (_formKey.currentState.validate()) {
                                  logIn();
                                }
                              },
                              child: Text(
                                "LOG IN",
                                style: buildRobotoTextStyle(14.0, Colors.black),
                              ),
                            ),
                          ),

                          Container(
                            width: 175.0,
                            height: 48.0,
                            margin:
                                const EdgeInsets.only(top: 7.50, bottom: 30.0),
                            child: FlatButton(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0))),
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                "Sign Up",
                                style: buildRobotoTextStyle(14.0, Colors.white),
                              ),
                            ),
                          ),
                        ])))));
  }

  logIn() async {
    setState(() {
      isLoading = true;
    });
    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
    if (result == null) {
      setState(() {
        errorString = 'Oops! Could not Sign In with these credentials';
        isLoading = false;
      });
    }

    //For Anonymous Sign in
    // dynamic resultUser = await _auth.signInAnon();
    // if (resultUser == null)
    //   print('Error in Anon Sign in');
    // else
    //   print(resultUser);
  }

  register() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SignUpPage()),
    // );
    print("REGISTER");
  }

  Widget buildTextField(BuildContext context, String label,
      TextEditingController controller, bool obscureText, bool isEmail) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 20.0, bottom: 8.0),
        child: Text(
          label,
          style: buildRobotoTextStyle(14.0, Colors.white),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          child: Theme(
            data: ThemeData(primaryColor: Colors.white),
            child: SizedBox(
                width: 240.0,
                height: 36.0,
                child: isEmail
                    ? buildEmailTextFormField(controller)
                    : buildPasswordTextFormField(controller, obscureText)),
          ))
    ]);
  }

  Widget buildPasswordTextFormField(
      TextEditingController controller, bool obscureText) {
    return TextFormField(
      maxLines: 1,
      controller: controller,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      obscureText: obscureText,
      showCursor: true,
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        fillColor: Colors.grey[200].withOpacity(0.75),
      ),
      style: buildRobotoTextStyle(14.0, Colors.white),
    );
  }

  Widget buildEmailTextFormField(TextEditingController controller) {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
      maxLines: 1,
      controller: controller,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a valid email ID';
        }
        return null;
      },
      showCursor: true,
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        fillColor: Colors.grey[200].withOpacity(0.75),
      ),
      style: buildRobotoTextStyle(14.0, Colors.white),
    );
  }

  Widget buildCheckBoxColumn(
      BuildContext context, bool value, Function onChanged, String label) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      child: Row(children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.grey),
          child: Row(children: [
            SizedBox(
              height: 30.0,
              width: 20.0,
              child: Checkbox(
                value: !value,
                onChanged: onChanged,
                checkColor: Colors.white,
                activeColor: seafoamGreen,
              ),
            ),

            // Horizontal padding
            SizedBox(
              width: 10.0,
            ),

            Text(
              label,
              style: buildRobotoTextStyle(14.0, Colors.white),
            ),
          ]),
        ),
      ]),
    );
  }
}
