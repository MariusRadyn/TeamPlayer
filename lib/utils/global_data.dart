

import 'package:flutter/material.dart';

const String USER_NAME = 'username';
const String DARK_THEME = 'darktheme';
const String DB_LOCAL = 'LocalDB.db';
const String DB_LOCAL_SONGS_TABLE = 'SongsTable';
const String DB_LOCAL_PLAYLIST_TABLE = 'PlaylistTable';

UserSettings userSettings = UserSettings('',false);
List<PlayListData> myPlayList = [];
List<LocalSongsLibrary> mySongsLibrary = [];

// Classes
class UserSettings{
  String userName;
  bool themeDark;

  UserSettings(
    this.userName,
    this.themeDark,
  );
}

class PlayListData {
  final String songName;
  final String writer;

  PlayListData({
    required this.songName,
    required this.writer,
  });
}

class LocalSongsLibrary {
  final int id;
  final String songName;
  final String author;
  final String genre;
  final String dateModified;
  final int isActive;

  const LocalSongsLibrary({
    required this.id,
    required this.songName,
    required this.author,
    required this.dateModified,
    required this.genre,
    this.isActive = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'songName': songName,
      'author' : author,
      'genre' : genre,
      'dateModified' : dateModified,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return 'DB_Local{id: $id, songName: $songName, author: $author, dateModified : $dateModified, isActive : $isActive}';
  }
}
