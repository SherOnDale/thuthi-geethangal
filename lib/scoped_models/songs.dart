import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/song.dart';
import '../data/songs_parser.dart';

class SongsModel extends Model {
  List<Song> hymns = [];
  List<Song> keerthanais = [];
  List<Song> paamalais = [];

  Song _selectedSong;

  bool _isNightMode = false;
  double _fontSize = 15.0;

  bool _isSearching = false;
  String _searchText = '';

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  List<Song> get allHymns {
    List<Song> filteredHymns = [];
    if (_isSearching && _searchText.isNotEmpty) {
      if (!_isNumeric(_searchText)) {
        for (int i = 0; i < hymns.length; i++) {
          String song = hymns.elementAt(i).title;
          if (song.contains(_searchText)) {
            filteredHymns.add(hymns.elementAt(i));
          }
        }
      } else if (hymns.length >= int.parse(_searchText) &&
          int.parse(_searchText) > 0) {
        filteredHymns.add(hymns.elementAt(int.parse(_searchText) - 1));
      }
    } else {
      filteredHymns = List.from(hymns);
    }
    return filteredHymns;
  }

  List<Song> get allKeerthanais {
    List<Song> filteredKeerthanais = [];
    if (_isSearching && _searchText.isNotEmpty) {
      if (!_isNumeric(_searchText)) {
        for (int i = 0; i < keerthanais.length; i++) {
          String keerthanai = keerthanais.elementAt(i).title;
          if (keerthanai.contains(_searchText)) {
            filteredKeerthanais.add(keerthanais.elementAt(i));
          }
        }
      } else if (keerthanais.length >= int.parse(_searchText) &&
          int.parse(_searchText) > 0) {
        for (int i = 0; i < keerthanais.length; i++) {
          int songNumber = keerthanais.elementAt(i).songNumber;
          if (songNumber == int.parse(_searchText)) {
            filteredKeerthanais.add(keerthanais.elementAt(i));
          }
        }
      }
    } else {
      filteredKeerthanais = List.from(keerthanais);
    }
    return filteredKeerthanais;
  }

  List<Song> get allPaamalais {
    List<Song> filteredPaamalais = [];
    if (_isSearching && _searchText.isNotEmpty) {
      if (!_isNumeric(_searchText)) {
        for (int i = 0; i < paamalais.length; i++) {
          String paamalai = paamalais.elementAt(i).title;
          if (paamalai.contains(_searchText)) {
            filteredPaamalais.add(paamalais.elementAt(i));
          }
        }
      } else if (paamalais.length >= int.parse(_searchText) &&
          int.parse(_searchText) > 0) {
        for (int i = 0; i < paamalais.length; i++) {
          int songNumber = paamalais.elementAt(i).songNumber;
          if (songNumber == int.parse(_searchText)) {
            filteredPaamalais.add(paamalais.elementAt(i));
          }
        }
      }
    } else {
      filteredPaamalais = List.from(paamalais);
    }
    return filteredPaamalais;
  }

  bool get isNightMode {
    return _isNightMode;
  }

  double get fontSize {
    return _fontSize;
  }

  void addHymn({
    List<List<String>> lyrics,
    String title,
    int songNumber,
    int orderNumber,
  }) {
    Song keerthanai = Song(
      lyrics: lyrics,
      title: title,
      songNumber: songNumber,
      orderNumber: orderNumber,
    );
    hymns.add(keerthanai);
  }

  void addKeerthanai({
    List<List<String>> lyrics,
    String title,
    int songNumber,
    int orderNumber,
  }) {
    Song keerthanai = Song(
      lyrics: lyrics,
      title: title,
      songNumber: songNumber,
      orderNumber: orderNumber,
    );
    keerthanais.add(keerthanai);
  }

  void addPamalai({
    List<List<String>> lyrics,
    String title,
    int songNumber,
    int orderNumber,
  }) {
    Song paamalai = Song(
      lyrics: lyrics,
      title: title,
      songNumber: songNumber,
      orderNumber: orderNumber,
    );
    paamalais.add(paamalai);
  }

  void selectSong(int index, String type) {
    switch (type) {
      case 'hymn':
        _selectedSong = hymns[index - 1];
        break;
      case 'keerthanai':
        for (int i = 0; i < keerthanais.length; i++) {
          if (keerthanais[i].songNumber == index) {
            _selectedSong = keerthanais[i];
            break;
          }
        }
        break;
      case 'paamalai':
        for (int i = 0; i < paamalais.length; i++) {
          if (paamalais[i].songNumber == index) {
            _selectedSong = paamalais[i];
            break;
          }
        }
        break;
    }
  }

  Song get selectedSong {
    return _selectedSong;
  }

  void toggleMode() async {
    _isNightMode = !_isNightMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('nightMode', _isNightMode);
  }

  void setMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('nightMode') != null) {
      _isNightMode = prefs.getBool('nightMode');
    }
  }

  void changeFontSize(bool mode) async {
    if (mode && _fontSize < 20) {
      _fontSize += 1.0;
    } else if (!mode && _fontSize > 10) {
      _fontSize -= 1.0;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontsize', _fontSize);
  }

  void getFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble('fontsize') != null) {
      _fontSize = prefs.getDouble('fontsize');
    }
  }

  void startSearching(String text) {
    _isSearching = true;
    _searchText = text;
    notifyListeners();
  }

  void stopSearching() {
    _isSearching = false;
    _searchText = '';
    notifyListeners();
  }

  SongsModel() {
    loadHymns().then((_hymns) {
      for (Song hymn in _hymns) {
        addHymn(
          lyrics: hymn.lyrics,
          title: hymn.title,
          songNumber: hymn.songNumber,
          orderNumber: hymn.orderNumber,
        );
      }
      hymns.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));
      notifyListeners();
    });

    loadKeerthanai().then((_keerthanais) {
      for (Song keerthanai in _keerthanais) {
        addKeerthanai(
          lyrics: keerthanai.lyrics,
          title: keerthanai.title,
          songNumber: keerthanai.songNumber,
          orderNumber: keerthanai.orderNumber,
        );
      }
      keerthanais.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));
      notifyListeners();
    });

    loadPaamalai().then((_paamalais) {
      for (Song paamalai in _paamalais) {
        addPamalai(
          lyrics: paamalai.lyrics,
          title: paamalai.title,
          songNumber: paamalai.songNumber,
          orderNumber: paamalai.orderNumber,
        );
      }
      paamalais.sort((a, b) => a.orderNumber.compareTo(b.orderNumber));
      notifyListeners();
    });
    setMode();
    getFontSize();
  }
}
