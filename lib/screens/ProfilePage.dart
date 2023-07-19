import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication/screens/login_page.dart';
import 'package:flutter_authentication/screens/RegisterPage.dart';
import 'package:flutter_authentication/utils/fire_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';


class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({required this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // bool _isSendingVerification = false;
  // bool _isSigningOut = false;
  // late User _currentUser;
  List<String> _Gender = ['Male', 'Female', 'Other'];

  var _selectGender;
  final _detailFormKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  @override
  void initState() {
    getProfileDetails();
    updateProfileDetails();
    //  deleteProfileDetails();
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance; 

    //  _currentUser = widget.user;
  }

//      Future<void> deleteProfileDetails() {
//    CollectionReference profileDetails =
//          FirebaseFirestore.instance.collection('profileDetails');
//          return profileDetails.doc('tS9dqCsPcQZPG2AYrVlxzrV6mR23').update({'city':FieldValue.delete()}).then((value) => print("city deleted")).catchError((onError) => print('Failed to delete city: $Error'));
//  }


  Future<void> updateProfileDetails() {
    CollectionReference profileDetails =
        FirebaseFirestore.instance.collection('profileDetails');
    return profileDetails
        .doc('tS9dqCsPcQZPG2AYrVlxzrV6mR23')
        .update({'city': 'Ongole'})
        .then((value) => print("city updated"))
        .catchError((onError) => print('Failed to upadte city: $Error'));
  }

  void getProfileDetails() async {
    CollectionReference profileDetails =
        FirebaseFirestore.instance.collection('profileDetails');
    final result = await profileDetails.doc(widget.user.uid).get();
    final details = result.data() as Map<String, dynamic>;
    _nameTextController.text = details['name'];
    _bioController.text = details['bio'];
    _ageController.text = details['age'].toString();
    _cityController.text = details['city'];
    _countryController.text = details['country'];
    _selectGender = details['gender'];
  }
  

  void _addImage() {
    var storage = FirebaseStorage.instance;
    List<String> ListOfImages = ['assets/images/image1.jpg'];
    ListOfImages.forEach((img) async{
      String imageName = img.substring(img.lastIndexOf("/"), img.lastIndexOf("."));
      String path = img.substring(img.indexOf("/"), img.lastIndexOf("/"));
      final Directory systemTempDir = Directory.systemTemp;
      final byteData = await rootBundle.load(img);
      final file = File('${systemTempDir.path}/$imageName.jpg');
      await  file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      TaskSnapshot taskSnapshot = await storage.ref('$path/$imageName').putFile(file);


     });}
 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              'Profile Page',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: 190.0,
                    padding: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Center(
                      child: Image.asset('assets/images/image1.jpg',width: 150,height: 150,),
                    ),
                  ),
                  
                  Form(
                    key: _detailFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nameTextController,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                )),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _bioController,
                          decoration: InputDecoration(
                              hintText: 'Bio',
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter bio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Age',
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter age';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        SizedBox(height: 18.0),
                        FormField<String>(
                            builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                hintText: 'Gender',
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0))),
                            child: DropdownButton(
                              hint: Text('Gender '),
                              value: _selectGender,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectGender = newValue;
                                });
                              },
                              items: _Gender.map((location) {
                                return DropdownMenuItem(
                                  child: Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          );
                        }),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _cityController,
                          decoration: InputDecoration(
                              hintText: 'City',
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter city';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _countryController,
                          decoration: InputDecoration(
                              hintText: 'Country',
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter country';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.0),
                        Row(children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                _addImage();
                                if (_detailFormKey.currentState!.validate()) {
                                  User? user =
                                      await FirebaseAuth.instance.currentUser;
                                  DocumentReference ref = FirebaseFirestore
                                      .instance
                                      .collection('profileDetails')
                                      .doc(user!.uid);
                                  await ref.set({
                                    'name': _nameTextController.text,
                                    'bio': _bioController.text,
                                    'age': int.parse(_ageController.text),
                                    'gender': _selectGender,
                                    'city': _cityController.text,
                                    'country': _countryController.text,
                                    'uid': user.uid,
                                  });
                                  print(ref);
                                }
                              },
                              child: Text('Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
