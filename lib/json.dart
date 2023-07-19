// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// void main() {
// runApp(MaterialApp(
//   home: JsonDemo(),
// ));
// }
// class JsonDemo extends StatefulWidget {
//   @override
//   State<JsonDemo> createState() => _JsonDemoState();
// }

// class _JsonDemoState extends State<JsonDemo> {
//   void getJsondata() async{
//     Response response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//     print(response.body);
//     List data = jsonDecode(response.body);
//     data.forEach((element) {
//       Map obj =  element;
//       String name = obj['name'];
//       print(name);
//       Map address = obj['address'];
//       String street = address['street'];
//       print(street);

//      });
//   }
// void initState() {
//   super.initState();
//   getJsondata();
// }
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }