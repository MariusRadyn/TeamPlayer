import 'package:flutter/material.dart';
import 'package:team_player/utils/helpers.dart';
import 'package:team_player/utils/firebase.dart';
import 'package:team_player/utils/global_data.dart';

// Tokens
const tokenTitle = "{title:";
const tokenSubtitle = "{subtitle:";
const tokenComment = "{comment:";
const tokenStartOfPart = "{start_of_part:";
const tokenEndOfPart = "{end_of_part}";
const tokenStartOfChorus = "{start_of_chorus}";
const tokenEndOfChorus = "{end_of_chorus}";
const tokenEndOfSong = "#";
const tokenTranspose = "# transpose =";
const tokenVersion = "# version =";

class ViewSong extends StatefulWidget {
  final List<Text> lstText;
  final String heading;

  const ViewSong({
    Key? key,
    required this.lstText,
    required this.heading,
  })  : super(key: key);

  @override
  _viewSong createState() => _viewSong();
}
class _viewSong extends State<ViewSong> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int _totalPages = 0;
  List<Size> _textSizes = [];
  List<List<Text>> _pages = [];
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _padBottom = 50.0;
  double _padTop = 10.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _textSizes = widget.lstText.map((text) => _calcTextSize(text)).toList();
    _totalPages = _calcTotalPages();
    List<List<Text>> _pages = _getSongPages();

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _totalPages,
        itemBuilder: (context, index) {
          //List<Text> texts = _getTextsForPage(index);
          return Container(
            padding: EdgeInsets.fromLTRB(5,_padTop,5,_padBottom),
            child: ListView(
              children: _pages[index],
            ),
          );
        },
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }

  Size _calcTextSize(Text text) {
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.of(context).textScaler,
      text: TextSpan(
          text: text.data,
          style: text.style
      ),
    )..layout();
    // Return the size of the text painter
    return textPainter.size;
  }
  int _calcTotalPages() {
    int totalPages = 1;
    double currentPageHeight = 0;
    for (Size textSize in _textSizes) {
      currentPageHeight += textSize.height;
      if (currentPageHeight > _screenHeight - _padTop -_padBottom) {
        totalPages++;
        currentPageHeight = textSize.height;
      }
    }
    return totalPages;
  }

  List<Text> _getTextsForPage(int pageIndex) {
    List<Text> texts = [];
    double currentPageHeight = 0;
    int currentPage = 0;
    double maxScreenHeight = _screenHeight - _padTop - _padBottom - 30;

    for (int i = 0; i < widget.lstText.length; i++) {
      Text text = widget.lstText[i];
      Size textSize = _textSizes[i];
      currentPageHeight += textSize.height;

      // Next page
      if (currentPageHeight > maxScreenHeight) {
        currentPage++;
        currentPageHeight = textSize.height;
      }

      // This Page
      if (currentPage == pageIndex) {
        texts.add(text);
      }
    }
    return texts;
  }

  List<List<Text>> _getSongPages() {
    List<List<Text>> lstPages = [];
    List<Text> lstText = [];
    double currentPageHeight = 0;
    double maxScreenHeight = _screenHeight - _padTop - _padBottom - 30;

    for (int i = 0; i < widget.lstText.length; i++) {
      Text text = widget.lstText[i];
      Size textSize = _textSizes[i];
      currentPageHeight += textSize.height;

      // Check End of page
      if (currentPageHeight > maxScreenHeight) {
        String? lastline = lstText[lstText.length-1].data!;

        // Check is last line was Chords
        if(lastline.contains('#')){
          Text lastText = lstText[i-1];
          Size lastSize = _textSizes[i-1];
          lstText.removeAt(i-1);
          lstPages.add([...lstText]); // Clone list

          lstText.clear();
          lstText.add(_stripLineTokens(lastText));
          currentPageHeight = lastSize.height;
        }
        else {
          currentPageHeight = textSize.height;
          lstPages.add([...lstText]);
          lstText.clear();
        }
      }

      // This Page
      lstText.add(_stripLineTokens(text));
    }
    lstPages.add(lstText);
    return lstPages;
  }
  List<List<Text>> x_getSongPages() {
    List<List<Text>> lstPages = [];
    List<Text> lstText = [];
    double currentPageHeight = 0;
    double maxScreenHeight = _screenHeight - _padTop - _padBottom - 30;

    for (int i = 0; i < widget.lstText.length; i++) {
      Text text = widget.lstText[i];
      Size textSize = _textSizes[i];
      currentPageHeight += textSize.height;

      // Check Next page
      if (currentPageHeight > maxScreenHeight) {
        String? lastline = lstText[lstText.length-1].data!;

        // Check is last line was Chords
        if(lastline.contains('#')){
          Text lastText = lstText[i-1];
          Size lastSize = _textSizes[i-1];
          lstText.removeAt(i-1);
          lstPages.add([...lstText]); // Clone list

          lstText.clear();
          lstText.add(_stripLineTokens(lastText));
          currentPageHeight = lastSize.height;
        }
        else {
          currentPageHeight = textSize.height;
          lstPages.add([...lstText]);
          lstText.clear();
        }
      }

      // This Page
      lstText.add(_stripLineTokens(text));
    }
    lstPages.add(lstText);
    return lstPages;
  }

  Text _stripLineTokens(Text text)
  {
    if(text.data!.contains("#")){
      return Text(
        text.data!.substring(1),
        style: songChordsStyle);
    }
    else return text;
  }
}

// Functions
Future<SongViewModel> GetSongFromCloud(int index) async {
  List<String> _songWords = [];
  List<String> _songChords = [];
  List<Text> _lstText = [];

  SongViewModel _songView = SongViewModel(
    songWords: _songWords,
    songChords: _songChords,
    lstText: _lstText,
  );

  String text = await fireReadFile(index);
  List<String> _lines = getLinesFromTxtFile(text);
  bool startOfChord = false;
  bool startOfChorus = false;

  for (String line in _lines)
  {
    // Title
    if(line.indexOf(tokenTitle) != -1){
      _songView.title = getToken(tokenTitle, line);
      _lstText.add(WriteSongLine(getToken(tokenTitle, line), songNameFontSize, Colors.white));
    }

    // Author
    else if(line.indexOf(tokenSubtitle) != -1) {
      _songView.author = getToken(tokenSubtitle, line);
      _lstText.add(WriteSongLine(getToken(tokenSubtitle, line), songAuthorFontSize, Colors.white24));
    }

    // Transpose, Version
    else if(line.indexOf(tokenEndOfSong) != -1) {
      _songView.transpose = getToken(tokenTranspose, text);
      _songView.version = getToken(tokenVersion, text);
      break;
    }

    // Song words and chords
    else {
      // {Start of Part}
      if(line.indexOf(tokenStartOfPart) != -1){
        _songWords.add(getToken(tokenStartOfPart, line));
        _songChords.add("");
        _lstText.add(WriteSongLine(getToken(tokenStartOfPart, line), songPartFontSize, Colors.white));
      }

      // {End of Part}
      else if(line.indexOf(tokenEndOfPart) != -1){
      }

      // {Comment}
      else if(line.indexOf(tokenComment) != -1){
        if(appSettings.showComments){
          _songWords.add(getToken(tokenComment, line));
          _songChords.add("");
          _lstText.add(WriteSongLine(getToken(tokenComment, line), songWordFontSize, Colors.grey));
        }
      }

      // {Start of Chorus}
      else if(line.indexOf(tokenStartOfChorus) != -1){
        startOfChorus = true;
        _songWords.add("Chorus");
        _songChords.add("");
        _lstText.add(WriteSongLine("Chorus", songPartFontSize, Colors.red));
      }

      // {End of Chorus}
      else if(line.indexOf(tokenEndOfChorus) != -1){
        startOfChorus = false;
      }

      // Words and Chords
      else{
        var lineChords = StringBuffer();
        var lineWords = StringBuffer();
        bool chordEntry = false;
        lineChords.write("#"); // Mark chord line with # token

        for(int i = 0; i < line.length;i++){
          if(line[i] == '[') {
            startOfChord = true;
            chordEntry = true;
            continue;
          }
          if(line[i] == ']') {
            startOfChord = false;
            continue;
          }
          if(startOfChord){
            // Chord
            lineChords.write(line[i]);
          }
          else {
            // Words
            lineWords.write(line[i]);
            lineChords.write(" ");
          }
        }

        // If a chord line has any chords, the line gets a "#" prefix
        // This # is used to determine what line contains chords
        // When splitting over multiple pages, the last line on a page
        // can not be a line containing chords. The # tells us that
        // line cant be last on a page
        if(chordEntry)chordEntry = false;
        else lineChords.clear();

        _songChords.add(lineChords.toString());
        _songWords.add(lineWords.toString());

        // Chords
        String _str = lineChords.toString();
        if(lineChords.toString() != "") {
          if(startOfChorus) _str = "  " + _str; // Indent Chorus
          _lstText.add(WriteSongLine(_str,songWordFontSize, Colors.deepOrangeAccent));
          //_lstText.add(WriteSongLine(_str,Colors.deepOrangeAccent));
        }
        // Words
        _str = lineWords.toString();
        if(startOfChorus) _str = "  " + _str; // Indent Chorus
        _lstText.add(WriteSongLine(_str,songWordFontSize, Colors.white));
      }
    }
  }

  // Format Song
  //var _song = StringBuffer();
  // for(int i = 0;i < _songWords.length;i++){
  //   if(_songChords[i] != "") _song.write(_songChords[i] + "\n");
  //   _song.write(_songWords[i] + "\n");
  // }
  return _songView;
}

// View Model
class SongViewModel {
  String title;
  String author;
  String version;
  String transpose;
  String originalChord;
  List<String> songWords;
  List<String> songChords;
  List<Text> lstText;

  SongViewModel({
    this.title = "",
    this.author = "",
    this.transpose = "",
    this.originalChord = "",
    this.version = "",
    required this.songWords,
    required this.songChords,
    required this.lstText,
  });
}
