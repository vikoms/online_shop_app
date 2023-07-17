import 'package:flutter/material.dart';

class CreditCardTextField extends StatefulWidget {
  const CreditCardTextField({super.key});

  @override
  _CreditCardTextFieldState createState() => _CreditCardTextFieldState();
}

class _CreditCardTextFieldState extends State<CreditCardTextField> {
  TextEditingController _controller = TextEditingController();
  String _previousText = '';
  bool _backspacePressed = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      maxLength: 19,
      style: TextStyle(
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: "Enter credit card number ...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20,
        ),
        suffixIcon: Image.asset(
          'assets/images/icon_master_card_without_bg.png',
          width: 2,
        ),
      ),
      onChanged: (text) {
        if (text.length > _previousText.length) {
          if (text.length == 4 || text.length == 9 || text.length == 14) {
            if (!_backspacePressed) {
              _controller.text = '${_controller.text} ';
              _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: _controller.text.length));
            }
          }
        } else {
          if (text.endsWith(' ')) {
            _controller.text = text.substring(0, text.length - 1);
            _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length));
          }
        }
        _previousText = _controller.text;
        _backspacePressed = false;
      },
      onSubmitted: (text) {
        _backspacePressed = false;
      },
      onEditingComplete: () {
        _backspacePressed = false;
      },
    );
  }
}
