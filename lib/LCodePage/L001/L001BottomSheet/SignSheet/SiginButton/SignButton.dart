import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'SignButtonOutputPort.dart';

class SignButton extends StatelessWidget {
  final SignButtonOutputPort signButtonOutputPort;
  final String label;
  final String imagePath;
  final SnsSupportService snsSupportService;

  SignButton(
      {@required this.signButtonOutputPort,
      @required this.label,
      @required this.snsSupportService,
      @required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xffd4d4d4)),
        ),
        height: 52,
        margin: EdgeInsets.only(right: 32, left: 32),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.circular(26.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(9),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(imagePath))),
                    ),
                    Text(label)
                  ],
                ),
                onTap: () {
                  signButtonOutputPort.trySign(snsSupportService);
                })));
  }
}
