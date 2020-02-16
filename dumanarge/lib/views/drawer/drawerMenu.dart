import 'package:dumanarge/authBloc/bloc.dart';
import 'package:dumanarge/localData/customerLocal.dart';
import 'package:dumanarge/routeBloc/bloc.dart';
import 'package:dumanarge/views/commonWidget/customText.dart';
import 'package:flutter/material.dart';

class drawerMenu extends StatefulWidget {
  RouteBloc routeBloc;
  AuthBloc authBloc;
  drawerMenu({this.routeBloc,this.authBloc});
  @override
  _drawerMenuState createState() => _drawerMenuState(routeBloc:routeBloc, authBloc:authBloc);
}

class _drawerMenuState extends State<drawerMenu> with SingleTickerProviderStateMixin {
  RouteBloc routeBloc;
  AuthBloc authBloc;
  _drawerMenuState({this.routeBloc,this.authBloc});


  AnimationController _controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    _customerGet();

    _controller = new AnimationController(
		  duration: const Duration(milliseconds: 2000),
		  vsync: this,
	  );

    _controller.addListener((){
		  setState((){});
	  });
	  _controller.forward().orCancel;

    offset = Tween<Offset>(begin: Offset(-2.0,0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

  }
  @override
  void dispose(){
	  _controller.dispose();
    super.dispose();
  }


  var items = [
    ['Store',Icons.store,RouteProductEvent()],
    ['Profile',Icons.person,RouteProfileEvent()],
  ];
  _customerGet()async{
    authBloc.customer = await customerGet();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor.withOpacity(0.5),
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: customText(label:"${authBloc.customer.name} ${authBloc.customer.surname}", color: Colors.white,),
              accountEmail: customText(label: "${authBloc.customer.email}", color: Colors.white,),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("${authBloc.customer.imgUrl}"),
                backgroundColor: Theme.of(context).primaryColorLight,
                radius: 20,
              ),
            ),
            ListView.separated(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context,i) => Divider(thickness: 1),
              itemCount: items.length,
              itemBuilder: (context, index){
                return drawerMenuItem(
                  offset: offset,
                  label: items[index][0],
                  icon: items[index][1],
                  onTap: (){
                    routeBloc.dispatch(items[index][2]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
            Divider(thickness: 1),
            drawerMenuItem(
              offset: offset,
              label: "Logout", icon: Icons.close, onTap: (){Navigator.pop(context);widget.authBloc.dispatch(Logout());},),
          ],
        ),
      ),
    );
  }
}

class drawerMenuItem extends StatelessWidget {
  String label;
  IconData icon;
  Function onTap;
  Animation<Offset> offset;
  drawerMenuItem({this.label,this.icon,this.onTap,this.offset});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:10,right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SlideTransition(
            position: offset,
            child: GestureDetector(
              onTap: onTap,
              child: customText(label:"$label", color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 15,),
            ),
          ),
          Icon(icon, color: Theme.of(context).primaryColor,),
        ],
      )
    );
  }
}