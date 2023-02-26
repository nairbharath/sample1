// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mind/model/request_model.dart';
import 'package:mentor_mind/screens/homescreen.dart';
import 'package:uuid/uuid.dart';
import '../utils/date_utils.dart' as date_util;

class RequestUpadatePage extends StatefulWidget {
  RequestUpadatePage({Key? key, required this.subjects, required this.dSnap});
  List<String> subjects;
  var dSnap;

  @override
  State<RequestUpadatePage> createState() => _RequestUpadatePageState();
}

class _RequestUpadatePageState extends State<RequestUpadatePage> {
  Future updateFile() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;
    // String requestID = const Uuid().v1();
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(user.uid).get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    String name = userData['name'];
    Request request = Request(
      topic: _selectedSubject == 'Others'
          ? _topicController.text
          : _selectedSubject,
      description: _noteController.text,
      uid: user.uid,
      name: name,
      date: date.toString(),
      type: selectedRadioButton,
      amount: _amountController.text,
      requestID: widget.dSnap['requestID'],
      datetime: DateTime.now(),
    );

    try {
      _firestore
          .collection('requests')
          .doc(widget.dSnap['requestID'])
          .update(request.toJson());
    } catch (e) {
      print(e.toString());
    }

    // try {
    //   _firestore.collection('users').doc(user.uid).update({
    //     'requests': FieldValue.arrayUnion([requestID])
    //   });
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  int date = DateTime.now().day;

  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  final _topicController = TextEditingController();
  final _noteController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedSubject = '';
  String selectedRadioButton = 'Theory';
  bool _isOther = false;
  int _selected = DateTime.now().day;

  @override
  void initState() {
    widget.subjects.add('Others');
    widget.subjects.remove('All');
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Widget hrizontalCapsuleListView() {
    return SizedBox(
      height: 140,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: currentMonthList.length,
              itemBuilder: (BuildContext context, int index) {
                return capsuleView(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
              date = (index + 1);
              _selected = date - 1;
            });
          },
          child: Container(
            width: 80,
            height: 140,
            decoration: BoxDecoration(
              border: index == _selected
                  ? Border.all(color: Color(0xFFC31DC7))
                  : Border.all(color: Color.fromARGB(255, 71, 69, 71)),
              // :
              // Border.all(color: Color(0xFF1F2029)),
              gradient: LinearGradient(
                  colors: (currentMonthList[index].day != currentDateTime.day)
                      ? [
                          Color(0xFF1F2029),
                          Color(0xFF1F2029),
                          Color(0xFF1F2029),
                        ]
                      : [
                          Color(0xFF1F2029),
                          Color(0xFF1F2029),
                          Color(0xFF1F2029),
                        ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                  stops: const [0.0, 0.5, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 28,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? Colors.white
                                : Colors.white),
                  ),
                  Text(
                    date_util.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? Colors.white
                                : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print("xxxxxxxxx");
    print(widget.dSnap['description']);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          leading: Icon(CupertinoIcons.back),
          title: Text('Ask for help'),
        ),
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Form(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        //

                        SizedBox(
                          height: 18,
                        ),

                        //
                        DropdownSearch<String>(
                          selectedItem: widget.dSnap['subject'],
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            showSelectedItems: true,
                          ),
                          items: widget.subjects,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              labelText: 'select topic',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _selectedSubject = val!;
                              if (_selectedSubject == 'Others') {
                                _isOther = true;
                              } else {
                                _isOther = false;
                              }
                            });
                          },
                        ),
                        if (_isOther)
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            width: double.infinity,
                            padding: EdgeInsets.only(top: _isOther ? 18 : 0),
                            child: TextField(
                              controller: _topicController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFC31DC7),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Color(0xFFC31DC7),
                                  ),
                                ),
                                labelText: 'please specify topic',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        //

                        SizedBox(
                          height: 18,
                        ),
                        TextField(
                          maxLines: 3,
                          maxLength: 100,
                          controller: _noteController,
                          decoration: InputDecoration(
                            hintText: widget.dSnap['description'],
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC31DC7),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Color(0xFFC31DC7),
                              ),
                            ),
                            labelText: 'Description',
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextField(
                          controller: _amountController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC31DC7),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Color(0xFFC31DC7),
                              ),
                            ),
                            labelText: 'Amount',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: RadioListTile(
                                  value: 'Theory',
                                  title: Text(
                                    'Theory',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  activeColor: Color(0xFFC31DC7),
                                  groupValue: selectedRadioButton,
                                  selectedTileColor: Color(0xFFC31DC7),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioButton = 'Theory';
                                    });
                                  }),
                            ),
                            Flexible(
                              child: RadioListTile(
                                  value: 'Practical',
                                  title: Text(
                                    'Practical',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  activeColor: Color(0xFFC31DC7),
                                  groupValue: selectedRadioButton,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioButton = 'Practical';
                                    });
                                  }),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        hrizontalCapsuleListView(),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          height: 60.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            shadowColor: Colors.blueAccent,
                            color: Color(0xFFC31DC7),
                            elevation: 0,
                            child: GestureDetector(
                              onTap: () {
                                updateFile();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
