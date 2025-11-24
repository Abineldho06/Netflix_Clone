import 'package:flutter/material.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('App Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            methodvideoplayback(),
            methodmobiledata(),
            Divider(color: Colors.grey),
            methodNotifications(),
            methodAllownotifi(),
            Divider(color: Colors.grey),
            methodDownloads(),
            methodwifi(),
            methodsmart(),
            methoddownloadvidquality(),
            methodlocation(),
            methodinternal(),
            Divider(color: Colors.grey),
            methodabout(),
            methodDevice(),
            methodaccount(),
            Divider(color: Colors.grey),
            methodDiagnistic(),
            methodChecknet(),
            methodplayback(),
            methodSpeedtest(),
            Divider(color: Colors.grey),
            methodlegal(),
            methodopensource(),
            methodprivacy(),
          ],
        ),
      ),
    );
  }

  Widget methodprivacy() {
    return ListTile(
      leading: Icon(Icons.lock, color: Colors.grey),
      title: Text('Privacy', style: TextStyle(color: Colors.white)),
    );
  }

  Widget methodopensource() {
    return ListTile(
      leading: Icon(Icons.description, color: Colors.grey),
      title: Text(
        'Open Source Licences',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget methodlegal() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Legal', style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }

  Widget methodSpeedtest() {
    return ListTile(
      leading: Icon(Icons.speed, color: Colors.grey),
      title: Text('Internet speed test', style: TextStyle(color: Colors.white)),
    );
  }

  Widget methodplayback() {
    return ListTile(
      leading: Icon(Icons.play_arrow, color: Colors.grey),
      title: Text(
        'Playback Specification',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget methodChecknet() {
    return ListTile(
      leading: Icon(Icons.network_check, color: Colors.grey),
      title: Text('Check network', style: TextStyle(color: Colors.white)),
    );
  }

  Widget methodDiagnistic() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Diagnostics',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget methodaccount() {
    return ListTile(
      leading: Icon(Icons.account_circle, color: Colors.grey),
      title: Text('Account', style: TextStyle(color: Colors.white)),
      subtitle: Text(
        'Email: unosshalu04@gmail.com',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget methodDevice() {
    return ListTile(
      title: Text('Device', style: TextStyle(color: Colors.white)),
      subtitle: Text(
        'Version: 9.38.0 build 5 (code 63520), OS API: 31,\narm64-v8a\nModel: POCO M2 Pro\nPL: 1, ChannelId:\n497730f0-ad4b-11e7-95a4-c7ad113ce187 (R), SSM:',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget methodabout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('About', style: TextStyle(color: Colors.white, fontSize: 18)),
    );
  }

  Widget methodinternal() {
    return ListTile(
      title: Text('Internal Storage', style: TextStyle(color: Colors.white)),
      subtitle: LinearProgressIndicator(
        value: 0.85,
        backgroundColor: Colors.grey,
        color: Colors.blue,
        minHeight: 10,
      ),
      trailing: Text('Default', style: TextStyle(color: Colors.grey)),
    );
  }

  Widget methodlocation() {
    return ListTile(
      leading: Icon(Icons.storage, color: Colors.grey),
      title: Text('Download Location', style: TextStyle(color: Colors.white)),
      subtitle: Text('Internal Storage', style: TextStyle(color: Colors.grey)),
    );
  }

  Widget methoddownloadvidquality() {
    return ListTile(
      leading: Icon(Icons.videocam, color: Colors.grey),
      title: Text(
        'Download Video Quality',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text('Standard', style: TextStyle(color: Colors.grey)),
    );
  }

  Widget methodsmart() {
    return ListTile(
      leading: Icon(Icons.smartphone, color: Colors.grey),
      title: Text('Smart Downloads', style: TextStyle(color: Colors.white)),
    );
  }

  Widget methodwifi() {
    return SwitchListTile(
      title: Text('Wi-Fi Only', style: TextStyle(color: Colors.white)),
      value: false,
      onChanged: null,
    );
  }

  Widget methodDownloads() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Downloads',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget methodAllownotifi() {
    return SwitchListTile(
      title: Text('Allow notifications', style: TextStyle(color: Colors.white)),
      subtitle: Text(
        'Customise in Settings → Notifications',
        style: TextStyle(color: Colors.grey),
      ),
      value: true,
      onChanged: null,
      activeColor: Colors.blue,
    );
  }

  Widget methodNotifications() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Notifications',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget methodmobiledata() {
    return ListTile(
      leading: Icon(Icons.signal_cellular_alt, color: Colors.grey),
      title: Text('Mobile Data Usage', style: TextStyle(color: Colors.white)),
      subtitle: Text('Automatic', style: TextStyle(color: Colors.grey)),
    );
  }

  Widget methodvideoplayback() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Video Playback',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
