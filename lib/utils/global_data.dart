import '../theme/theme_manager.dart';

const String USER_NAME = 'username';
const String DARK_THEME = 'darktheme';
const String NR_OF_COLUMNS = 'nrofcolumns';
const String DB_LOCAL = 'LocalDB.db';
const String DB_TABLE_SONGS_LIB = 'SongsTable';
const String DB_TABLE_PLAYLIST_LIB = 'PlaylistsTable';
const String DB_TABLE_PLAYLIST_ITEMS = 'PlaylistItemsTable';

AppSettings appSettings = AppSettings();
ThemeManager themeManager = ThemeManager();

List<PlayListData> myPlayList = <PlayListData>[];
List<LocalSongsLibrary> mySongsLibrary = <LocalSongsLibrary>[];

// App Settings
class AppSettings{
  String userName;
  bool themeDark;
  bool showComments;
  int nrOfColumns;

  AppSettings({
    this.userName = "",
    this.themeDark = true,
    this.nrOfColumns = 2,
    this.showComments = false,
  });
}

class PlayListData {
  final String songName;
  final String writer;

  PlayListData({
    required this.songName,
    required this.writer,
  });
}

// Database Schemas
class LocalSongsLibrary {
  final int id;
  final String songName;
  final String author;
  final String genre;
  final String dateCreated;
  final String dateModified;
  final String dateLastViewed;
  final int isActive;

  const LocalSongsLibrary({
    required this.id,
    required this.songName,
    required this.author,
    required this.genre,
    this.dateModified = '',
    this.dateCreated = "",
    this.dateLastViewed = "",
    this.isActive = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'songName': songName,
      'author' : author,
      'genre' : genre,
      'dateModified' : dateModified,
      'dateCreated' : dateCreated,
      'dateLastViewed' : dateLastViewed,
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return 'DB_Local{'
        'id: $id, '
        'songName: $songName, '
        'author: $author, '
        'dateModified : $dateModified, '
        'dateCreated : $dateCreated, '
        'dateLastViewed : $dateLastViewed, '
        'isActive : $isActive}';
  }
}

class LocalPlaylistLibrary {
  final int id;
  final String description;
  final String dateCreated;
  final String dateModified;
  final int nrOfItems;

  const LocalPlaylistLibrary({
    required this.id,
    required this.description,
    required this.dateCreated,
    this.dateModified = '',
    this.nrOfItems = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'description': description,
      'dateCreated': dateCreated,
      'dateModified': dateModified,
    };
  }

  @override
  String toString() {
    return 'DB_Local{'
    'id: $id, '
    'description: $description, '
    'dateCreated: $dateCreated, '
    'dateModified: $dateModified';
  }
}

class LocalPlaylistItems {
  final int id;
  final String songName;
  final String author;
  final String genre;

  const LocalPlaylistItems({
    required this.id,
    required this.songName,
    required this.author,
    required this.genre,
  });

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'songName': songName,
      'author' : author,
      'genre' : genre,
    };
  }

  @override
  String toString() {
    return 'DB_Local{'
        'id: $id, '
        'songName: $songName, '
        'author: $author, ';
  }
}
