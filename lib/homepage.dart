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

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text('Random API User'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: getData, // Call getData() when the button is pressed
            icon: Icon(Icons.refresh), // Use a refresh icon
          ),
        ],
      ),
      body: RefreshIndicator(child: ListView(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  ClipOval(child: Image.network(data[0]['results'][0]['picture']['large'])),
                  Text('$name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),)

                ],
              )),

          Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Country: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('$country', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Email: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('$email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Username: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('$username', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gender: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('$gender', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phone Number: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('$phoneNumber', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cellphone Number: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('$cell', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date of Birth: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('$dob', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Street Number: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('$streetNumber', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),