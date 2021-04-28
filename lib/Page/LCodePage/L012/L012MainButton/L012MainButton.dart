import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L012MainButton extends StatelessWidget {

  final Function? onTap;
  final String? title;
  final String? description;

  const L012MainButton({Key? key, this.onTap, this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => L012MainButtonViewModel(),
      child: Consumer<L012MainButtonViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Material(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffE4E7E8)),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                onTap: () {
                  onTap!();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 0, 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Container(
                              child: Column(
                                children: [
                                  Text(title!,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        color: const Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    description!,
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff5b5b5b),
                                      letterSpacing: -0.28,
                                      height: 1.5714285714285714,
                                    ),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ))),
                      SizedBox(
                        width: 61,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        child: Icon(Icons.chevron_right),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class L012MainButtonViewModel extends ChangeNotifier {

}
