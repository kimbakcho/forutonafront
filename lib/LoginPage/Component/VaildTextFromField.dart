import 'package:flutter/material.dart';

class VaildTextFromFieldItem {
  String text;
  Function(String) onchange;
  FormFieldValidator<String> validator;
  String hintText;
  TextInputType inputtype;
  bool obscureText = false;
  VaildTextFromFieldItem(
      {this.text,
      this.onchange,
      this.validator,
      this.hintText,
      this.inputtype,
      this.obscureText});
}

class VaildTextFromField extends StatefulWidget {
  VaildTextFromField({this.item, Key key}) : super(key: key);
  final VaildTextFromFieldItem item;
  @override
  _VaildTextFromFieldState createState() {
    return _VaildTextFromFieldState(item: item);
  }
}

class _VaildTextFromFieldState extends State<VaildTextFromField> {
  _VaildTextFromFieldState({this.item});

  TextEditingController textcontroller = new TextEditingController();
  VaildTextFromFieldItem item;

  @override
  void initState() {
    super.initState();
    textcontroller.addListener(() {
      item.text = textcontroller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double top = (constraints.maxHeight / 2) - 15;
      return Container(
        child: Stack(
          children: <Widget>[
            TextFormField(
              controller: textcontroller,
              onChanged: item.onchange == null ? null : item.onchange,
              keyboardType: item.inputtype,
              obscureText: item.obscureText != null ? item.obscureText : false,
              decoration: InputDecoration(
                  
                  fillColor: Colors.white,
                  filled: true,
                  hintText: item.hintText,
                  hintStyle: TextStyle(
                    fontFamily: "NotoSansKR",
                    fontSize: 15,
                    color: Color(0xff78849e).withOpacity(0.56),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)))),
              validator: item.validator,
            ),
            textcontroller.text.length != 0
                ? Positioned(
                    right: 16,
                    top: top,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              this.item.validator(textcontroller.text) == null
                                  ? Theme.of(context).primaryColor
                                  : Color(0xFFB1B1B1)),
                      height: 28,
                      width: 28,
                      child: Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}
