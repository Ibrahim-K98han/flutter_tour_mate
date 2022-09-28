import 'package:flutter/material.dart';
import 'package:flutter_tour_mate/pages/home_page.dart';

import '../auth/firebase_authentication.dart';

class LoginPage extends StatefulWidget {

  static final routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FirebaseAuthenticationService authenticationService;
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLogin = true;
  String errMsg = '';
  String? uid;
  @override
  void initState() {
    authenticationService = FirebaseAuthenticationService();
    super.initState();
  }

  void _authenticate() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      authenticationService.currentUser;
      try{
        if(isLogin){
         uid = await authenticationService.login(email!, password!);
        }else{
          uid = await authenticationService.register(email!, password!);
        }
        if(uid != null){
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      }catch(error){
        setState(() {
          errMsg = error.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child:Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Enter Email Address',
                      border: OutlineInputBorder()
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'This field must not be emapty';
                      }
                      return null;
                    },
                    onSaved: (value){
                      email = value;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Enter Password',
                        border: OutlineInputBorder()
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'This field must not be emapty';
                      }
                      return null;
                    },
                    onSaved: (value){
                      password = value;
                    },
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text('Signup',style: TextStyle(color: Colors.black),),
                        onPressed: (){
                          setState(() {
                            isLogin = false;
                          });
                          _authenticate();
                        },
                      ),
                      ElevatedButton(
                        child: Text('SignIn',style: TextStyle(color: Colors.white),),
                        onPressed: _authenticate,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(errMsg,style: TextStyle(fontSize: 16,color: Colors.red),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
