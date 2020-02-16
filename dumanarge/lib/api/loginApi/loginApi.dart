import 'package:dumanarge/localData/customerLocal.dart';
import 'package:dumanarge/models/customerModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class loginApi{

  Future login(String username, String password)async{

    Customer customer = Customer();
    customer.name="Name";
    customer.surname="Surname";
    customer.email="mail@gmail.com";
    customer.username="$username";
    customer.password="$password";

    // await request api
    await customerSave(customer);
    // await
    return true;
  }
  
 

}