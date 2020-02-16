import 'package:dumanarge/authBloc/auth_bloc.dart';
import 'package:dumanarge/authBloc/auth_event.dart';
import 'package:dumanarge/views/commonWidget/customText.dart';
import 'package:dumanarge/views/commonWidget/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Theme.of(context).primaryColorLight,Theme.of(context).primaryColor]
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left:20, right:20),
            child: Card(
              child: ListView(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  logo(height: 80),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _textFormField(_usernameController, "Username", false),
                          _textFormField(_passwordController, "Password", true),
                          RaisedButton(
                            child: customText(label:"Login", color: Theme.of(context).backgroundColor, fontWeight: FontWeight.bold,),
                            onPressed: (){
                              if(_formKey.currentState.validate()){
                                authBloc.dispatch(Login(username: _usernameController.text, password: _passwordController.text));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFormField(TextEditingController controller, String title, bool obscure){
    return ListTile(
      dense: true,
      title: customText(label:"$title", fontWeight: FontWeight.bold, alignment: Alignment.centerLeft,),
      subtitle: SizedBox(
        height: 50,
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            hintText: "Enter",
            hintStyle: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade400
            ),
            border: new OutlineInputBorder(
              //borderRadius: new BorderRadius.circular(5.0),
              borderSide: new BorderSide(),
            ),
          ),
          validator: (value){
            if(value.isEmpty){
              return "Can't be empty";
            }
            return null;
          },
        ),
      ),
    );
  }



}
