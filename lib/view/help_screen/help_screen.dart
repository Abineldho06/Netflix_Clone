import 'package:flutter/material.dart';
import 'package:netflix_clone/core/constants/image_constants.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset(ImageConstants.logoimage, width: 120),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //Title
          methodTitle(),
          //HelpCenter
          methodHelpcenter(),
          //Request Title
          methodRequestTitle(),
          //Connection Issue
          methodConnectionIssue(),
          //Privacy Issue
          methodPrivacy(),
          //Terms of Use
          methodTerms(),
          //Contact Us
          methodContactUs(),
          //Text
          Methodtext(),
          //Button for call and sms
          methodButtons(),
        ],
      ),
    );
  }

  Widget methodButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: null,
          child: Icon(Icons.phone, color: Colors.black),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: null,
          child: Icon(Icons.chat, color: Colors.black),
        ),
      ],
    );
  }

  Widget Methodtext() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'We will connect the call for free using your internet connection.',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget methodContactUs() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Contact us',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget methodTerms() {
    return ListTile(
      leading: Icon(Icons.description, color: Colors.blue),
      title: Text('Terms of Use', style: TextStyle(color: Colors.black)),
    );
  }

  Widget methodPrivacy() {
    return ListTile(
      leading: Icon(Icons.shield, color: Colors.blue),
      title: Text('Privacy Statement', style: TextStyle(color: Colors.black)),
    );
  }

  Widget methodConnectionIssue() {
    return ListTile(
      leading: Icon(Icons.settings, color: Colors.blue),
      title: Text(
        'Fix a Connection Issue',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget methodRequestTitle() {
    return ListTile(
      leading: Icon(Icons.add, color: Colors.blue),
      title: Text('Request a Title', style: TextStyle(color: Colors.black)),
    );
  }

  Widget methodHelpcenter() {
    return ListTile(
      leading: Icon(Icons.headset_mic, color: Colors.blue),
      title: Text('Help Centre', style: TextStyle(color: Colors.black)),
    );
  }

  Widget methodTitle() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Find help online',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
