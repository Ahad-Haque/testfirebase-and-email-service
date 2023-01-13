// import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:emailjs/emailjs.dart';

class FirebaseTest extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  FirebaseTest({super.key});

  @override
  State<FirebaseTest> createState() => _FirebaseTestState();
}

class _FirebaseTestState extends State<FirebaseTest> {
  final _texController = TextEditingController();
  final _texController2 = TextEditingController();
  final _texController3 = TextEditingController();
  final _texController4 = TextEditingController();

  void _sendmail() async {
    EmailJS.init(const Options(
      publicKey: 'qfY9z1iJp6iSALdFR',
      privateKey: 'OVti-9XxXhYv6tPvn75yG',
    ));
    try {
      await EmailJS.send('service_1fsej0l', 'template_4fw41ue', {
        'user_email': _texController4.text,
        'message': _texController3.text,
        'name': _texController.text,
        'subject': _texController2.text,
      });
      print('success!!');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
  }

  CollectionReference gatherdata =
      FirebaseFirestore.instance.collection('gatherdata');

  String name = '';
  String email = '';
  String phone = '';
  String sendmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
              controller: _texController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Your Name'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
                controller: _texController2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your subject',
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
                controller: _texController3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your massage',
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(() async {
                name = _texController.text;
                email = _texController2.text;
                phone = _texController3.text;
                await gatherdata
                    .add({'name': name, 'email': email, 'phone': phone});
              });
            },
            child: Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Save info to database",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
                controller: _texController4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email to send info',
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              print('pressed');
              // sendEmail();
              _sendmail();
            },
            child: Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Send",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
