import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class KCodeTopFilterBar extends StatelessWidget {
  final String searchText;
  final String descriptionText;
  final String searchResultCountText;
  final KCodeTopFilterBarListener kCodeTopFilterBarListener;

  const KCodeTopFilterBar(
      {Key key,
      this.searchText,
      this.descriptionText,
      this.searchResultCountText,
      this.kCodeTopFilterBarListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => KCodeTopFilterBarViewModel(),
        child: Consumer<KCodeTopFilterBarViewModel>(
          builder: (_, model, __) {
            return Row(children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 100
                ),
                child: Text("\"$searchText\" ",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xff3497fd),
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Container(
                child: Text(
                  "$descriptionText",
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff454f63),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                child: Text("($searchResultCountText)",
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xff454f63),
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Spacer(),
              RawMaterialButton(
                constraints: BoxConstraints(minWidth: 0, minHeight: 0),
                onPressed: () {
                  kCodeTopFilterBarListener.openFilter();
                },
                child: Icon(ForutonaIcon.filter),

              )
            ]);
          },
        ));
  }
}

class KCodeTopFilterBarViewModel extends ChangeNotifier {}

abstract class KCodeTopFilterBarListener {
  void openFilter();
}
