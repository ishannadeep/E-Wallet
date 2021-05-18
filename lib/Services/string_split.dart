splitText(String _string, int _num) {
  List<String> _temp_str = _string.split(".");
  String _neededString = _temp_str[0];
  int _length = _neededString.length;
  double _parts;
  List<String> _tem = [];
  int _module = _length % _num;
  String _reversedstring = _neededString.split('').reversed.join();

  if (_module == 0) {
    _parts = _length / _num;
  } else {
    _parts = _length - _module / _num;
  }
  int _x = 0;
  int _y = _parts.toInt() + 1;
  int _tempnum = _num;
  for (int i = 0; i < _y; i++) {
    if (_module != 0) {
      if (i == _y - 1) {
        _tem.add(_reversedstring.substring(_x, _x + _module));
      } else {
        _tem.add(_reversedstring.substring(_x, _num) + ",");
      }
    } else {
      if (i == _y - 2) {
        _tem.add(_reversedstring.substring(_x));
      } else if (i < _y - 2) {
        _tem.add(_reversedstring.substring(_x, _num) + ",");
      }
    }

    _x = _num;
    _num = _num + _tempnum;
  }
  return _tem.join().split('').reversed.join();
}
