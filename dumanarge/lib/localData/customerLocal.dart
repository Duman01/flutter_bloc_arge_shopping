import 'package:dumanarge/models/customerModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

Future customerCheck()async{
  final name = await storage.read(key: "name");
  return name!=null ? true:false;
}

Future customerSave(Customer customer)async{
  await storage.write(key: "name", value: customer.name);
  await storage.write(key: "surname", value: customer.surname);
  await storage.write(key: "email", value: customer.email);
  await storage.write(key: "username", value: customer.username);
  await storage.write(key: "password", value: customer.password);
  return true;
}

Future<Customer> customerGet()async{
  Customer customer=Customer();
  customer.name = await storage.read(key: "name");
  customer.surname = await storage.read(key: "surname");
  customer.email = await storage.read(key: "email");
  customer.username = await storage.read(key: "username");
  customer.password = await storage.read(key: "password");
  return customer;
}

Future customerDelete()async{
  await storage.delete(key: "name");
  await storage.delete(key: "surname");
  await storage.delete(key: "email");
  await storage.delete(key: "username");
  await storage.delete(key: "password");
  return true;
}