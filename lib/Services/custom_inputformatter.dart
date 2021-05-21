import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue
      ) {
    RegExp exp = RegExp(
        r"^\d+\.?\d{0,2}$");

   String  _string=newValue.text.split(',').join();
    if(exp.hasMatch(_string)){
      if(_string!=null){
        int hasdot=_string.indexOf('.');
        List<String> _temp_str = _string.split(".");
        String _neededString = _temp_str[0];
        int _length = _neededString.length;
        double _parts;
        List<String> _tem = [];
        int _num=3;
        int _module = _length % _num;
        String _reversedstring = _neededString.split('').reversed.join();

        if (_module == 0) {
          _parts = _length / _num;
        } else {
          _parts = (_length - _module) / _num;
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

        if(_temp_str.length==1 && hasdot==-1){
          String tempstr=_tem.join().split('').reversed.join();
          return TextEditingValue(
              text:tempstr,

              selection: TextSelection.fromPosition(TextPosition(offset: newValue.selection.baseOffset))
          );
        }

        else if(hasdot!=-1 && _temp_str.length==2){
          String tempstr=_tem.join().split('').reversed.join()+"."+_temp_str[1];
          return TextEditingValue(

              text:tempstr,

              selection: TextSelection.fromPosition(TextPosition(offset: newValue.selection.baseOffset))
          );
        }

        else if(hasdot!=-1 && _temp_str.length==1){
          String tempstr=_tem.join().split('').reversed.join()+".";

          return TextEditingValue(
              text:tempstr,

              selection: TextSelection.fromPosition(TextPosition(offset: newValue.selection.baseOffset))
          );
        }

      }
    }else{
      return TextEditingValue(
          text:oldValue.text,

          selection: TextSelection.fromPosition(TextPosition(offset: oldValue.selection.baseOffset))
      );
    }


  }
}

class DateInputFormatters extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    RegExp exp = RegExp(
        r"^\d{1,31}+\-+\d{1,12}+\d$");
    if(exp.hasMatch(newValue.text))
      {

      }
    throw UnimplementedError();
  }



}