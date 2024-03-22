import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'variables.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async'; // Import dart:async for TimeoutException
import 'dart:io'; // Import dart:io to access SocketException

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? name;
  String? country;
  String? gender;
  String? email;
  String? username;
  String? phoneNumber;
  String? streetNumber;
  String? streetName;
  String? city;
  String? state;
  String? postcode;
  String? latitude;
  String? longitude;
  String? timezoneOffset;
  String? timezoneDescription;
  String? dob;
  String? registeredDate;
  String? phone;
  String? cell;
  String? idName;
  String? idValue;
  String? nationality;


  Future<void> getData() async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 6));
      print("connected");
      setState(() {
        data = [jsonDecode(response.body)];

        // Move the initialization of UI-related variables inside setState
        name = data[0]['results'][0]['name']['title'] + '. ' + data[0]['results'][0]['name']['first'] +' '+ data[0]['results'][0]['name']['last'];
        country = data[0]['results'][0]['location']['country'];
        gender = data[0]['results'][0]['gender'];
        email = data[0]['results'][0]['email'];
        username = data[0]['results'][0]['login']['username'];
        phoneNumber = data[0]['results'][0]['phone'];

        // Fetching additional data
        streetNumber = data[0]['results'][0]['location']['street']['number'].toString();
        streetName = data[0]['results'][0]['location']['street']['name'];
        city = data[0]['results'][0]['location']['city'];
        state = data[0]['results'][0]['location']['state'];
        postcode = data[0]['results'][0]['location']['postcode'];
        latitude = data[0]['results'][0]['location']['coordinates']['latitude'];
        longitude = data[0]['results'][0]['location']['coordinates']['longitude'];
        timezoneOffset = data[0]['results'][0]['location']['timezone']['offset'];
        timezoneDescription = data[0]['results'][0]['location']['timezone']['description'];
        dob = data[0]['results'][0]['dob']['date'];
        registeredDate = data[0]['results'][0]['registered']['date'];
        phone = data[0]['results'][0]['phone'];
        cell = data[0]['results'][0]['cell'];
        idName = data[0]['results'][0]['id']['name'];
        idValue = data[0]['results'][0]['id']['value'];
        nationality = data[0]['results'][0]['nat'];
      });

      await Future.delayed(Duration(seconds: 3));
    } catch (e) {
      if (e is TimeoutException || e is SocketException) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Message'),
              content: Text('No internet connection'),
              actions: [
                TextButton(
                  onPressed: () {
                    getData();
                    Navigator.pop(context);
                  },
                  child: Text('Retry'),
                )
              ],
            );
          },
        );
      } else {
        print('Error: $e');
      }
    }
  }