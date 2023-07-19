// import 'dart:async'; 
// import 'dart:convert';
//  import 'package:flutter/material.dart';
//   import 'package:http/http.dart' as http;
//   Future<List<Album>> fetchAlbum() async { 
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
//     if (response.statusCode == 200) { 
//       print(response.body); 
//       return jsonDecode(response.body).map<Album>((data) => Album.fromJson(data)) .toList();
//       } else {
//          throw Exception('Failed to load album'); } }
//          class Album {
//            final int userId;
//             final int id;
//              final String title; 
//              const Album({ 
//               required this.userId,
//                required this.id, 
//                required this.title, 
//                });
//                factory Album.fromJson(Map<String, dynamic> json) {
//                  return Album(
//                    userId: json['userId'],
//                     id: json['id'], 
//                     title: json['title'],
//                      ); } }
//       void main() => runApp(const MyApp()); 
//       class MyApp extends StatefulWidget {
//          const MyApp({super.key});
//          @override
//           State<MyApp> createState() => _MyAppState(); 
          
//         } 
//         class _MyAppState extends State<MyApp> 
//         {
//            late Future<List<Album>> futureAlbum;
//            @override
//             void initState() {
//                super.initState();
//                 futureAlbum = fetchAlbum(); 
//                 }
//                 @override
//                  Widget build(BuildContext context) {
//                    return MaterialApp(
//                      title: 'Fetch Data Example', 
//                      theme: ThemeData(
//                        primarySwatch: Colors.blue,
//                         ),
//                         home: Scaffold( 
//                           appBar: AppBar(
//                              title: const Text('Fetch Data Example'),
//                               ),
//                               body: Center(
//                                  child: FutureBuilder<List<Album>>(
//                                    future: futureAlbum,
//                                     builder: (context, snapshot) {
//                                        if (snapshot.hasData) {
//                                         return ListView.builder( 
//                                           itemCount: snapshot.data!.length,
//                                            itemBuilder: (context, index){ 
//                                             return Container( 
//                                               child: Column(
//                                                 children: [
//                                                   Text(snapshot.data![index].id.toString()),
//                                                    Text(snapshot.data![index].userId.toString()),
//                                                     Text(snapshot.data![index].title),
//                                                      const Divider(height: 1.0,
//                                                       color: Colors.black,) ],), ); });
//                                                       } else if (snapshot.hasError) { 
//                                                         return Text('${snapshot.error}'); 
//                                                         }
//                                                         return const CircularProgressIndicator(); }, ), ), ), ); } }