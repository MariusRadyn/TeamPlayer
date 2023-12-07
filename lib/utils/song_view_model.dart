import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:team_player/utils/helpers.dart';
import 'package:team_player/utils/firebase.dart';
import 'package:team_player/utils/global_data.dart';

// Tokens
const tokenTitle = "{title:";
const tokenSubtitle = "{subtitle:";
const tokenComment = "{comment:";
const tokenDefine = "{define:";
const tokenStartOfPart = "{start_of_part:";
const tokenEndOfPart = "{end_of_part}";
const tokenStartOfChorus = "{start_of_chorus}";
const tokenEndOfChorus = "{end_of_chorus}";
const tokenStartOfTab = "{start_of_tab}";
const tokenEndOfTab = "{end_of_tab}";
const tokenLineOfChords = "#C";
const tokenEndOfSong = "#";
const tokenTranspose = "# transpose =";
const tokenVersion = "# version =";

class ViewSong extends StatefulWidget {
  final SongViewModel songView;

  const ViewSong({
    Key? key,
    required this.songView,
  }) : super(key: key);

  @override
  _viewSong createState() => _viewSong();
}

class _viewSong extends State<ViewSong> {
  final PageController _pageController = PageController();
  List<Size> _textSizes = [];
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _padBottom = 50.0;
  double _padTop = 10.0;
  double _maxScreenHeight = 0;

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
    _screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    _screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    //_textSizes = widget.songView.lstTextWords.map((text) => _calcTextSize(text))
    //    .toList();
    //_totalPages = _calcTotalPages();
    _maxScreenHeight = _screenHeight - _padTop - _padBottom - 30;
    List<List<Text>> columns = _getSongColumns();
    int nrOfPages = 1;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.songView.title,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.blue
            ),
          ),
          Text(
            widget.songView.author,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.blueGrey
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return PageView.builder(
                  itemBuilder: (BuildContext context, int pageIndex) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: appSettings.nrOfColumns,
                          crossAxisSpacing: 10,
                          mainAxisExtent: _maxScreenHeight,
                        ),
                        itemBuilder: (BuildContext context, int widgetIndex) {
                          if (widgetIndex < columns.length) {
                            nrOfPages++;
                            return Container(alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15)),

                              //padding: EdgeInsets.fromLTRB(5,_padTop,5,_padBottom),
                              child: ListView(
                                children: columns[widgetIndex],
                              ),
                            );
                          }
                          else {
                            return null;
                          }
                        }
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          SmoothPageIndicator(
            controller: _pageController,
            count: nrOfPages,
            effect: WormEffect(
              dotColor: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              activeDotColor: Theme
                  .of(context)
                  .colorScheme
                  .onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Size _calcTextSize(String str) {
    if (str == "") return const Size(0, 0);

    Text myText = Text(str);
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery
          .of(context)
          .textScaler,
      text: TextSpan(
          text: myText.data,
          style: myText.style
      ),
    )
      ..layout();
    // Return the size of the text painter
    return textPainter.size;
  }

  int _calcTotalPages() {
    int totalPages = 1;
    double currentPageHeight = 0;
    for (Size textSize in _textSizes) {
      currentPageHeight += textSize.height;
      if (currentPageHeight > _screenHeight - _padTop - _padBottom) {
        totalPages++;
        currentPageHeight = textSize.height;
      }
    }
    return totalPages;
  }

  List<List<Text>> _getSongPages() {
    List<List<Text>> lstPages = [];
    List<Text> lstText = [];
    double currentPageHeight = 0;

    for (int i = 0; i < widget.songView.lstTextWords.length; i++) {
      Text txt = widget.songView.lstTextWords[i];
      Size textSize = _textSizes[i];
      currentPageHeight += textSize.height;

      // Check End of page
      if (currentPageHeight > _maxScreenHeight) {
        String? lastline = widget.songView.lstTextWords[lstText.length - 1]
            .data!;

        // Check if last line was Chords
        if (lastline.contains('#')) {
          Text lastText = widget.songView.lstTextWords[i - 1];
          Size lastSize = _textSizes[i - 1];
          lstText.removeAt(i - 1);
          lstPages.add([...lstText]); // Clone list

          lstText.clear();
          lstText.add(_stripLineTokens(lastText));
          currentPageHeight = lastSize.height;
        }
        else {
          currentPageHeight = textSize.height;
          lstPages.add([...lstText]); // Clone List
          lstText.clear();
        }
      }

      // This Page

      lstText.add(_stripLineTokens(widget.songView.lstTextWords[i]));
    }
    lstPages.add(lstText);
    return lstPages;
  }

  List<List<Text>> _getSongColumns() {
    List<List<Text>> lstColumns = [];
    List<Text> lstText = [];
    double currentPageHeight = 0;
    double maxScreenHeight = _screenHeight - _padTop - _padBottom - 30;
    double maxColumnWidth = _screenWidth / appSettings.nrOfColumns - 10;

    // Itterate Words/Chords Lines
    for (int i = 0; i < widget.songView.songWords.length; i++) {
      String words = widget.songView.songWords[i];
      String chords = widget.songView.songChords[i];
      Size sizeWords = _calcTextSize(words);
      Size sizeChords = _calcTextSize(chords);
      String tempWords = "";
      String tempChords = "";

      // Assume words is the longest
      Size bigestSize = sizeWords;
      if (sizeChords.width > sizeWords.width) {
        bigestSize = sizeChords;
      }

      // Calc Line span
      int span = (bigestSize.width / maxColumnWidth).ceil();
      if (span == 0) span = 1;

      // Break line up in correct words
      if (span > 1) {
        for (int spanCnt = 0; spanCnt < span; spanCnt++) {
          currentPageHeight += (sizeWords.height + sizeChords.height);
          List<String> lst = words.split(" ");

          // Look 1 word ahead and break the line
          // if the next word will not fit
          for (int i = 0; i < lst.length; i++) {
            if (i < lst.length - 2) {
              tempWords += lst[i] + " ";

              double currentLen = _calcTextSize(tempWords + lst[i + 1]).width;
              if (currentLen > maxColumnWidth) {

                // Break Chords
                if(chords.length > tempWords.length){
                  tempChords = chords.substring(0, tempWords.length);
                  lstText.add(Text(tempChords));
                  chords = chords.replaceFirst(tempChords,"");
                }
                else {
                  lstText.add(Text(tempChords));
                  chords = chords.replaceFirst(tempChords,"");
                }

                lstText.add(Text(tempWords));
                words = words.replaceFirst(tempWords, "");
              }
            }
            // Last word
            else {-+
              lstText.add(Text(chords));
              lstText.add(Text(words));
              break;
            }
          }
        }
      }
      else {
        currentPageHeight += (sizeWords.height + sizeChords.height);
        lstText.add(Text(chords));
        lstText.add(Text(words));
      }
      //lstText.add(_stripLineTokens(widget.lstTextWords[i]));

      if (currentPageHeight >= _maxScreenHeight) {
        lstColumns.add([...lstText]);
        lstText.clear();
      }
    }
    return lstColumns;
  }

  Text _stripLineTokens(Text text) {
    // # = Line of Chords
    if (text.data!.contains(tokenLineOfChords)) {
      return Text(
          text.data!.replaceAll(tokenLineOfChords, ""),
          style: songChordsStyle);
    }
    else return text;
  }
}

// Functions
Future<SongViewModel> getSongFromCloud(int index) async {
  List<String> _songWords = [];
  List<String> _songChords = [];
  List<Text> _lstTextWords = [];
  List<Text> _lstTextChords = [];

  SongViewModel _songView = SongViewModel(
    songWords: _songWords,
    songChords: _songChords,
    lstTextWords: _lstTextWords,
    lstTextChords: _lstTextChords,
  );

  String text = await fireReadFile(index);
  List<String> _lines = getLinesFromTxtFile(text);
  bool startOfChord = false;
  bool startOfChorus = false;

  for (String line in _lines) {
    // Title
    if (line.indexOf(tokenTitle) != -1) {
      _songView.title = getToken(tokenTitle, line);
      //_lstTextWords.add(WriteSongLine(getToken(tokenTitle, line), songNameFontSize, Colors.white));
    }

    // Author
    else if (line.indexOf(tokenSubtitle) != -1) {
      _songView.author = getToken(tokenSubtitle, line);
      //_lstTextWords.add(WriteSongLine(getToken(tokenSubtitle, line), songAuthorFontSize, Colors.white24));
    }

    // Transpose, Version
    else if (line.indexOf(tokenEndOfSong) != -1) {
      _songView.transpose = getToken(tokenTranspose, text);
      _songView.version = getToken(tokenVersion, text);
      break;
    }

    // Song words and chords
    else {
      // {Start of Part}
      if (line.indexOf(tokenStartOfPart) != -1) {
        _songWords.add(getToken(tokenStartOfPart, line));
        _songChords.add("");

        _lstTextChords.add(const Text(""));
        _lstTextWords.add(WriteSongLine(getToken(
            tokenStartOfPart, line), songPartFontSize, Colors.white));
      }

      // {End of Part}
      else if (line.indexOf(tokenEndOfPart) != -1) {}

      // {Comment}
      else if (line.indexOf(tokenComment) != -1) {
        if (appSettings.showComments) {
          _songWords.add(getToken(tokenComment, line));
          _songChords.add("");

          _lstTextChords.add(const Text(""));
          _lstTextWords.add(WriteSongLine(
              getToken(tokenComment, line), songWordFontSize, Colors.grey));
        }
      }

      // {define}
      else if (line.indexOf(tokenDefine) != -1) {
        if (appSettings.showDefine) {
          _songWords.add(getToken(tokenDefine, line));
          _songChords.add("");

          _lstTextChords.add(const Text(""));
          _lstTextWords.add(WriteSongLine(
              getToken(tokenDefine, line), songWordFontSize, Colors.grey));
        }
      }

      // {Start of Tabs}
      else if (line.indexOf(tokenStartOfTab) != -1) {
        if (appSettings.showTabs) {
          _songWords.add(getToken(tokenStartOfTab, line));
          _songChords.add("");

          _lstTextChords.add(const Text(""));
          _lstTextWords.add(WriteSongLine(
              getToken(tokenStartOfTab, line), songWordFontSize, Colors.grey));
        }
      }

      // {end of Tabs}
      else if (line.indexOf(tokenEndOfTab) != -1) {}

      // {Start of Chorus}
      else if (line.indexOf(tokenStartOfChorus) != -1) {
        startOfChorus = true;
        _songWords.add("Chorus");
        _songChords.add("");

        _lstTextChords.add(const Text(""));
        _lstTextWords.add(
            WriteSongLine("Chorus", songPartFontSize, Colors.red));
      }

      // {End of Chorus}
      else if (line.indexOf(tokenEndOfChorus) != -1) {
        startOfChorus = false;
      }

      // Words and Chords
      else {
        var sbChords = StringBuffer();
        var sbWords = StringBuffer();
        bool chordEntry = false;
        //lineChords.write(tokenLineOfChords); // Mark chord line with #C token

        for (int i = 0; i < line.length; i++) {
          if (line[i] == '[') {
            startOfChord = true;
            chordEntry = true;
            continue;
          }
          if (line[i] == ']') {
            startOfChord = false;
            continue;
          }
          if (startOfChord) {
            // Chord
            sbChords.write(line[i]);
          }
          else {
            // Words
            sbWords.write(line[i]);
            sbChords.write(" ");
          }
        }

        // If a chord line has any chords, the line gets a "#" prefix
        // This # is used to determine what line contains chords
        // When splitting over multiple pages, the last line on a page
        // can not be a line containing chords. The # tells us that
        // line cant be last on a page
        //if(chordEntry)chordEntry = false;
        //else lineChords.clear();

        _songChords.add(sbChords.toString());
        _songWords.add(sbWords.toString());

        // Chords
        String _str = sbChords.toString();
        if (_str != "") {
          if (startOfChorus) {
            _str = "  " + _str; // Indent Chorus
          }
          _lstTextChords.add(
              WriteSongLine(_str, songWordFontSize, Colors.deepOrangeAccent));
        }
        // Words
        _str = sbWords.toString();
        if (startOfChorus) _str = "  " + _str; // Indent Chorus
        _lstTextWords.add(WriteSongLine(_str, songWordFontSize, Colors.white));
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
  List<Text> lstTextWords;
  List<Text> lstTextChords;

  SongViewModel({
    this.title = "",
    this.author = "",
    this.transpose = "",
    this.originalChord = "",
    this.version = "",
    required this.songWords,
    required this.songChords,
    required this.lstTextWords,
    required this.lstTextChords,
  });
}
