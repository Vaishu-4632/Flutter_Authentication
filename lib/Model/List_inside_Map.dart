// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// // Future<List<employeeStatus>> fetchEmployeeStatus() async {
// //   final response = await http
// //       .get(Uri.parse('https://dummy.restapiexample.com/employee'));

// //   if (response.statusCode == 200) {
// //     print(response.body);
// //     return jsonDecode(response.body).map<employeeStatus>((data) => employeeStatus.fromJson(data)).toList();
    
// //   } else {
// //     throw Exception('Failed to load employee status');
// //   }
// // }
// class EmployeeList {
//   String? status;
//   List<Data>? data;
//   String? message;

//   EmployeeList({this.status, this.data, this.message});

//   EmployeeList.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = message;
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? employeeName;
//   int? employeeSalary;
//   int? employeeAge;
//   String? profileImage;

//   Data(
//       {this.id,
//       this.employeeName,
//       this.employeeSalary,
//       this.employeeAge,
//       this.profileImage});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     employeeName = json['employee_name'];
//     employeeSalary = json['employee_salary'];
//     employeeAge = json['employee_age'];
//     profileImage = json['profile_image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['employee_name'] = employeeName;
//     data['employee_salary'] = employeeSalary;
//     data['employee_age'] = employeeAge;
//     data['profile_image'] = profileImage;
//     return data;
//   }
// }

// void main() => runApp(const MyApp());
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
// class _MyAppState extends State<MyApp> {
//   Future<EmployeeList> fetchEmployeeStatus() async {
//   final response = await http
//       .get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
//   if (response.statusCode == 200) {
//     print(response.body);
//     return EmployeeList.fromJson(jsonDecode(response.body));
    
//   } else {
//     throw Exception('Failed to load employee status');
//   }
// }

//    late Future<EmployeeList> futureEmployeeStatus;
//   @override
//   void initState() {
//     super.initState();
//     futureEmployeeStatus = fetchEmployeeStatus();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center( 
//           child: FutureBuilder<EmployeeList>(
//             future: futureEmployeeStatus,
//             builder: (context, snapshot) {
//               print(snapshot.data);
//                if (snapshot.hasData) {
//                  return ListView.builder(
//                   itemCount: snapshot.data!.data!.length,
//                   itemBuilder: (context, index){
//                     final empList = snapshot.data!.data;
//                     return Container(
//                       child: Column(
//                           children: [
//                          Text(empList![index].employeeAge.toString()),
//                          Text(empList[index].employeeName.toString()),
//                         Text(empList[index].employeeSalary.toString()),
//                          Text(empList[index].employeeAge.toString()),
//                         Text(empList[index].profileImage.toString()),
//                         const Divider(height:  1.0,color: Colors.black,)
//                       ],
//                       ),
//                     );
//                   },
//                  );
//                }else if(snapshot.hasError){
//                 return Text('${snapshot.error}');
//                }
//                return const CircularProgressIndicator();
//                }
//           ),
//         ),
//       ),
//     );
//   }
// }
