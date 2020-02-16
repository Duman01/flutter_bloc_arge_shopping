// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    String name;
    String surname;
    String email;
    String username;
    String password;
    String imgUrl;

    Customer({
        this.name,
        this.surname,
        this.email,
        this.username,
        this.password,
        this.imgUrl="https://s3.amazonaws.com/uifaces/faces/twitter/follettkyle/128.jpg"
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "username": username,
        "password": password,
    };
}
