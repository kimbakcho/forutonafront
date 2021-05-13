import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuestBottomActionButton extends StatelessWidget {
  final String text;

  final Color color;

  final Color backGroundColor;

  final Function? onTap;

  QuestBottomActionButton(
      {required this.text,
      required this.color,
      required this.backGroundColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestBottomActionButtonViewModel(),
      child: Consumer<QuestBottomActionButtonViewModel>(
        builder: (_, model, child) {
          return Container(
            width: 80,
            height: 30,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(backGroundColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(width: 2, color: color)))),
              onPressed: () {
                if (onTap != null) {
                  onTap!();
                }
              },
              child: Text(
                text,
                style: GoogleFonts.notoSans(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuestBottomActionButtonViewModel extends ChangeNotifier {}
