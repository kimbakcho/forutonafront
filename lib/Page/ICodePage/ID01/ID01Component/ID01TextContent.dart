import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ID01TextContent extends StatelessWidget {
  final String content;
  final String makeTime;

  ID01TextContent({@required this.content, @required this.makeTime});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: Container(
                    child: SelectableAutoLinkText(
              content,
              linkStyle: const TextStyle(color: Colors.blueAccent),
              highlightedLinkStyle: TextStyle(
                color: Colors.blueAccent,
                backgroundColor: Colors.blueAccent.withAlpha(0x33),
              ),
              onTap: (url) => launch(url, forceSafariVC: false),
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: const Color(0xff000000),
                letterSpacing: -0.32,
                height: 1.5625,
              ),
              textAlign: TextAlign.left,
            )))
          ]),
          // Row(children: <Widget>[
          //   Expanded(
          //       child: Container(
          //           child: Text(
          //     makeTime,
          //     style: GoogleFonts.notoSans(
          //       fontSize: 13,
          //       color: const Color(0xffb8b8b8),
          //     ),
          //     textAlign: TextAlign.right,
          //   )))
          // ])
        ]));
  }
}
