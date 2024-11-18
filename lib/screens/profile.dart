import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/screens/login.dart';
import 'package:food_app/services/auth.dart';
import 'package:food_app/services/service.dart';
import 'package:food_app/services/shared_pref.dart';
import 'package:food_app/widget/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? id, name, email, profile;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  gettheSharedPre() async {
    id = await SharedPreferenceHelper().getUserId();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    profile = await SharedPreferenceHelper().getUserProfile();
    setState(() {});
    print(profile);
  }

  onTheLoad() async {
    await gettheSharedPre();
  }

Future<void> setProfile() async {
  final updatedProfile = await SharedPreferenceHelper().getUserProfile();

  setState(() {
    profile = updatedProfile;
    selectedImage = null;
  });
}

  Future<void> getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
      await uploadProfile();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  Future<void> uploadProfile() async {
    if (selectedImage != null) {
      try {
        final supabase = Supabase.instance.client;

        String productId = randomAlphaNumeric(10);

        final response = await supabase.storage.from('HalalFoodApp').upload(
              '$productId.jpg',
              selectedImage!,
            );

        final imageUrl = supabase.storage
            .from('HalalFoodApp')
            .getPublicUrl('$productId.jpg');

        await SharedPreferenceHelper().saveUserProfile(imageUrl);
        await DatabaseMethods()
            .updateUserProfile(id.toString(), imageUrl!)
            .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );

         
        });
 setProfile();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updated profile: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a image')),
      );
    }
  }

  @override
  void initState() {
    onTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4.5,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 133, 54),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 105.0))),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 8),
                    child: GestureDetector(
                      onTap: getImage,
                      child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width / 2),
                        child: profile == null
                            ? Container(
                                width: 150.0,
                                height: 150.0,
                                child: const Icon(Icons.camera_alt_outlined))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 2),
                                child: Image.network(
                                  profile.toString(),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name.toString(),
                        style: AppWidget.headLineText2Style(),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 28.0,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: AppWidget.semiBoldText2Style(),
                          ),
                          Text(
                            name.toString(),
                            style: AppWidget.lightText2Style(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 28.0,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: AppWidget.semiBoldText2Style(),
                          ),
                          Text(
                            email.toString(),
                            style: AppWidget.lightText2Style(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Icon(
                        Icons.description,
                        size: 28.0,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Terms and condition',
                            style: AppWidget.semiBoldText2Style(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: GestureDetector(
                  onTap: () {
                    AuthMethods().deleteUser();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 28.0,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delete Account',
                              style: AppWidget.semiBoldText2Style(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 5.0,
                child: GestureDetector(
                  onTap: () async{
                    await AuthMethods().deleteUser();

                    await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return const Login();
                    },));
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 28.0,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Logout Account',
                              style: AppWidget.semiBoldText2Style(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
