import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mind/data/request_slider.dart';
import 'package:mentor_mind/screens/profile.dart';
import 'package:mentor_mind/screens/request.dart';
import 'package:mentor_mind/utils/category_box.dart';
import 'package:mentor_mind/utils/category_box_for_filter.dart';
import 'package:mentor_mind/utils/search_box.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  List<String> types = ['All', 'Physics', 'DS', 'Maths', 'Chemisty', 'ML'];
  final user = FirebaseAuth.instance.currentUser!;
  var name = '';
  var _selectedTopic = 'All';
  var _filtertopic = 'All';
  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      name = (snap.data() as Map<String, dynamic>)['name'];
    });
  }

  void setStatus(String status) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({"status": status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setStatus("online");
    } else {
      setStatus("offline");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("online");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Hello $name 👋',
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestPage(
                  subjects: types,
                ),
              ),
            ),
            child: Icon(
              CupertinoIcons.add,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            ),
            child: Icon(
              CupertinoIcons.person_crop_circle_fill,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Find Jobs',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Satoshi',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: types.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTopic = types[index];
                              _filtertopic = types[index];
                            });
                          },
                          child: CategoryBoxForFilter(
                            filterTopic: _filtertopic,
                            name: types[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: SearchBar(placehold: "Search.."),
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Icon(Icons.filter_alt_sharp),
          //   ],
          // ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              children: [
                RequestSlider(
                  selectedTopic: _selectedTopic,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
