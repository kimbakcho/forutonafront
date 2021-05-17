import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QDPointWidget extends StatelessWidget {

  final String title;

  final Icon icon;

  final Position position;

  final String address;

  final Function(Position,String)? onTap;

  QDPointWidget({required this.title,required this.position, required this.address,required this.icon,this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QDStartPointWidgetViewModel(),
      child: Consumer<QDStartPointWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff000000),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () {
                      if(onTap != null){
                        onTap!(position,address);
                      }
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(double.infinity,46)),
                      backgroundColor: MaterialStateProperty.all(Color(0xffF6F6F6)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(13))))
                    ),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            child: icon,
                          ),
                          SizedBox(width: 12),
                          Text(address,
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff2f3035),
                                letterSpacing: -0.28,
                                fontWeight: FontWeight.w500,
                                height: 1.2142857142857142,
                              ))
                        ],
                      ),
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}

class QDStartPointWidgetViewModel extends ChangeNotifier {}
