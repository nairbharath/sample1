import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mentor_mind/auth/auth_methods.dart';
import 'package:mentor_mind/auth/login_page.dart';
import 'package:mentor_mind/screens/applications.dart';
import 'package:mentor_mind/screens/mentor_profile.dart';
import 'package:mentor_mind/screens/requests.dart';
import 'package:wiredash/wiredash.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  var name = '';
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      name = (snap.data() as Map<String, dynamic>)['name'];
    });
  }

  void signOutUser() async {
    await AuthMethods().signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '$name',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (!user.isAnonymous) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfilePic(
                        name: name,
                      ),
                      const SizedBox(height: 20.0),
                      ProfileMenu(
                        press: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MentorProfile(
                                mentorID: '123',
                              ),
                            ),
                          );
                        },
                        menuText: 'Account Settings',
                        icon: CupertinoIcons.person_crop_circle,
                      ),
                      ProfileMenu(
                        press: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PersonalApplicationsView()));
                        },
                        menuText: "Applications",
                        icon: CupertinoIcons.doc_on_clipboard,
                      ),
                      ProfileMenu(
                        press: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PersonalRequestsView(),
                            ),
                          );
                        },
                        menuText: "Requests",
                        icon: CupertinoIcons.arrow_left_right_circle,
                      ),
                      ProfileMenu(
                        press: () {},
                        menuText: "Settings",
                        icon: CupertinoIcons.settings,
                      ),
                      ProfileMenu(
                        press: () {
                          signOutUser();
                        },
                        menuText: "Log Out",
                        icon: CupertinoIcons.lock_circle,
                      ),
                      ProfileMenu(
                        press: () {
                          Wiredash.of(context).show(inheritMaterialTheme: true);
                        },
                        menuText: "Help Center",
                        icon: CupertinoIcons.person_2,
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    ProfilePic(
                      name: name,
                    ),
                    const SizedBox(height: 20.0),
                    ProfileMenu(
                      press: () {
                        signOutUser();
                      },
                      menuText: 'log in',
                      icon: CupertinoIcons.person_crop_circle,
                    ),
                    ProfileMenu(
                      press: () {},
                      menuText: "Help Center",
                      icon: CupertinoIcons.person_2,
                    ),
                  ],
                );
              }
            } else {
              return Container();
            }
          }),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.menuText,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String menuText;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(20.0),
          ),
          backgroundColor: MaterialStateProperty.all(
            const Color.fromARGB(255, 228, 228, 228),
          ),
        ),
        onPressed: () {
          press();
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                menuText,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Icon(
              CupertinoIcons.right_chevron,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 245, 244, 244),
            child: Container(
              height: 70,
              width: 70,
              child: name != ''
                  ? SvgPicture.network(
                      'https://avatars.dicebear.com/api/identicon/$name.svg',
                    )
                  : LoadingAnimationWidget.waveDots(
                      color: Colors.black, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
