import 'package:dumanarge/authBloc/bloc.dart';
import 'package:dumanarge/localData/customerLocal.dart';
import 'package:dumanarge/views/commonWidget/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {

  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  List<bool> edit = [false,false,false,false,false];
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    _customer(authBloc);
  }
  _customer(AuthBloc authBloc)async{
    name.text=authBloc.customer.name;
    surname.text=authBloc.customer.surname;
    email.text=authBloc.customer.email;
    username.text=authBloc.customer.username;
    password.text=authBloc.customer.password;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage("${authBloc.customer.imgUrl}"),
                      backgroundColor: Theme.of(context).primaryColorDark,
                      radius: 40,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          _profileItem("Name", name,0),
                          _profileItem("Surname", surname,1),
                          _profileItem("Email", email,2),
                          _profileItem("Username", username,3),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _profileItem(String header, TextEditingController controller, int i){
    return ListTile(
      title: customText(label:"$header", color: Theme.of(context).primaryColor, alignment: Alignment.centerLeft,),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 30,
              child: TextFormField(
                controller: controller,
                enabled: edit[i],
                maxLines: 1,
                obscureText: header.toLowerCase()=="password" ? true:false,
                style: TextStyle(
                  color: Colors.black45
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  saveCustomer(header.toLowerCase(), value);
                },
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: edit[i]?Theme.of(context).primaryColorDark:null,
            ),
            onPressed: (){
              setState(() {
                edit[i]=!edit[i];
              });
            },
          ),
        ],
      ),
    );
  }
  
  saveCustomer(String header, String value)async{
    await storage.write(key: "$header", value: value);
  }


}