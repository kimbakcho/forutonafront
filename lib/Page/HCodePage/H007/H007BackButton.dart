import 'package:flutter/material.dart';

class H007BackButton extends StatelessWidget {
  const H007BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.white,
        shape: CircleBorder(),
        child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 36,
                height: 36,
                child: Icon(Icons.close, color: Color(0xff454F63), size: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          offset: Offset(0, 3),
                          blurRadius: 6)
                    ]))),
      ),
    );
  }
}
