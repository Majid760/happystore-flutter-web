import 'package:admin/Widget/bezierContainer.dart';
import 'package:admin/controllers/AuthController.dart';
import 'package:admin/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main/components/dialogBox.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKeySignUp = GlobalKey<FormState>();
  // SignUp form  attributes
  String email;
  String username;
  String password;
  bool _obscureTextSignUp;
  bool loading;
  @override
  void initState() {
    super.initState();
    _obscureTextSignUp = true;
    loading = false;
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  // signup Form,

  Widget _signupForm() {
    return Container(
      child: Form(
        key: _formKeySignUp,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                child: TextFormField(
                    style: TextStyle(color: Colors.deepOrangeAccent),
                    keyboardType: TextInputType.text,
                    onChanged: (val) => {
                          setState(() {
                            username = val;
                          }),
                        },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid User name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        prefixIcon: Icon(Icons.person, color: Colors.orange),
                        labelText: 'User name',
                        labelStyle: TextStyle(color: Colors.blueGrey[700]),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        suffix: Icon(Icons.person, color: Colors.orange))),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  child: TextFormField(
                style: TextStyle(color: Colors.deepOrangeAccent),
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => {
                  setState(() {
                    email = val;
                  }),
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    prefixIcon: Icon(Icons.email, color: Colors.orange),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.blueGrey[700]),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                    suffix: Icon(Icons.email, color: Colors.orange)),
              )),
              SizedBox(
                height: 30,
              ),
              Container(
                child: TextFormField(
                  style: TextStyle(color: Colors.deepOrangeAccent),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureTextSignUp,
                  onChanged: (val) => {
                    setState(() {
                      password = val;
                    }),
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Please enter valid password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.blueGrey[700]),
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      suffix: InkWell(
                        child: Icon(
                            _obscureTextSignUp
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.orange),
                        onTap: () {
                          setState(() {
                            _obscureTextSignUp = !_obscureTextSignUp;
                          });
                        },
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(2, 4),
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xfffbb448), Color(0xfff7892b)])),
                    child: Center(
                        child: Text('Register Now',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                  ),
                  onTap: () {
                    if (_formKeySignUp.currentState.validate()) {
                      dynamic user = Authentication()
                          .registerWithNameEmailAndPassword(
                              username, email, password, context);
                      if (user == null) {
                        msgDialog(
                            context, 'something went wrong,please try again!');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              
                              'Proceding further ...',
                              style: TextStyle(color: Colors.deepOrangeAccent),
                              textAlign:TextAlign.center,
                            )));
                      }
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  // toggle hide and show password
  void _togglePasswordView() {
    setState(() {
      _obscureTextSignUp = !_obscureTextSignUp;
    });
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'h',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'appy',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            TextSpan(
              text: 'store',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Container(child: _signupForm());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ),
      ),
    );
  }
}
