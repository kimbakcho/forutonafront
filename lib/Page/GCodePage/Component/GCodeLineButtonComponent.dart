import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GCodeLineButtonComponent extends StatelessWidget {
  final Icon? icon;

  final String? text;

  final Function? onTap;

  const GCodeLineButtonComponent({Key? key, this.icon, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => GCodeLineButtonComponentViewModel(),
        child: Consumer<GCodeLineButtonComponentViewModel>(
            builder: (_, model, child) {
          return Material(
            child: InkWell(
                onTap: () {
                  onTap!();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      icon!,
                      SizedBox(width: 8,),
                      Text(
                        text!,
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: const Color(0xff3a3e3f),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ]))),
            color: Colors.transparent,
          );
        }));
  }
}

class GCodeLineButtonComponentViewModel extends ChangeNotifier {}
