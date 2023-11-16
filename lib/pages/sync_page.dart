import 'dart:io';
import 'package:flutter/material.dart';
import 'package:team_player/utils/helpers.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:firebase_core/firebase_core.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  @override
  void initState() {
    super.initState();
    //ftpConnect();
  }

    ftpConnect() async{
    try{
      String user= '936a2ec9@radyndesign.co.za';
      String host= 'http://www.radyndesign.co.za';
      String pw = '*va#Qy!2kZ0wBk5Z';
      String IP ='160.119.252.16';
      print('Connecting FTP: $host');

      FTPConnect ftpConnect = FTPConnect(
          IP,
          user:user,
          pass:pw,
          showLog: true
      );
      File fileToUpload = File('fileToUpload.txt');
      await ftpConnect.connect();
      var res = await ftpConnect.listDirectoryContent();
      String dir = await ftpConnect.currentDirectory();
      //bo//bool res = await ftpConnect.uploadFileWithRetry(fileToUpload, pRetryCount: 2);

      if(await ftpConnect.makeDirectory('mari')) {
        print("/ does not Exist");
      }
      if(await ftpConnect.changeDirectory('mari')) {
        print("/home does not Exist");
      }
      if(await ftpConnect.checkFolderExistence('/etc')) {
        print("/etc does not Exist");
      }
      if(await ftpConnect.checkFolderExistence('/home/radyndes')) {
        ftpConnect.createFolderIfNotExist('teamplayer');
      }

      ftpConnect.changeDirectory('teamplayer');
      res = await ftpConnect.listDirectoryContent();
      await ftpConnect.disconnect();
      print(res);
      //ftp://936a2ec9%2540radyndesign.co.za@radyndesign.co.za/teamplayer/Anne_Wilson_-My_Jesus__.gcp
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sync'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.lightBlue,
              child: Text('Hallo almal'),
            
            ),
          ],
        ),
      ) ,
    );
  }
}
