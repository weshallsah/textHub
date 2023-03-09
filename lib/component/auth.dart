import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authfrom extends StatefulWidget {
  bool isloading;
  final void Function(String email,String password,String username,bool islogin) submitfm;
  Authfrom(this.submitfm,this.isloading);
  @override
  State<Authfrom> createState() => _AuthfromState();
}

class _AuthfromState extends State<Authfrom> {
  final _formkey = GlobalKey<FormState>();
  var _islogin=true;
  var _Username='';
  var _password='';
  var _Email='';

  void _trysumbmit(){
    final isvalid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();


    if(isvalid as bool ){
        _formkey.currentState?.save();
       widget.submitfm(_Email,_password,_Username,_islogin,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(25),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  TextFormField(
                    // controller: _Email,
                    key: const ValueKey('Email'),
                    validator: (value) {
                      if(value ==null || !value.contains('@')){
                          return 'please enter valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email@gmail.com',
                        labelStyle: TextStyle(fontSize: 28)),
                        onSaved: (Value) => _Email=Value as String,
                  ),

                  if(!_islogin)
                  TextFormField(
                    // controller: _Username,
                    key: const ValueKey('username'),
                    validator: (value) {
                      if(value == null||value.length < 7){
                          return 'please enter username';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(fontSize: 28)),
                    onSaved: (Value) => _Username =Value as String,
                  ),
                  TextFormField(
                    // controller: _password,
                    key: const ValueKey('password'),
                    validator: (value) {
                      if(value ==null || value.length < 8){
                          return 'password is to short';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'password',
                        labelStyle: TextStyle(fontSize: 28)),
                    onSaved: (Value) => _password=Value as String,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  if(widget.isloading)
                    CircularProgressIndicator(),
                  
                  if(!widget.isloading)
                  ElevatedButton(
                    onPressed: _trysumbmit,
                    child:  Text(_islogin ?'Login':'Signup',style: const TextStyle(fontSize: 28),),
                  ),

                  if(!widget.isloading)                  
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                        
                      },
                      child: Text(
                        _islogin?"Don't have account":"i have account",
                        style:const  TextStyle(fontSize: 18),
                      ))
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
