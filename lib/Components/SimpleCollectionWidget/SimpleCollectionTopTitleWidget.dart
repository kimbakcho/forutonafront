import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleCollectionTopTitleWidget extends StatelessWidget {
  final String? searchText;
  final SimpleCollectionTopNextPageListener? simpleCollectionTopNextPageListener;
  final String? titleDescription;

  const SimpleCollectionTopTitleWidget(
      {Key? key,
      this.searchText,
      this.simpleCollectionTopNextPageListener,
      this.titleDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
      child: InkWell(
        onTap: () {
          simpleCollectionTopNextPageListener!.onNextPage(searchText!);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xffE4E7E8)))),
          child: Row(
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 0,maxWidth: 100),
                child: Text("\"$searchText\"",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xff3497fd),
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Expanded(
                child: Container(
                  child: Text(" $titleDescription",
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: const Color(0xff454f63),
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              Container(
                child: Icon(
                  Icons.chevron_right,
                  color: Color(0xff2F3035),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

abstract class SimpleCollectionTopNextPageListener {
  void onNextPage(String searchText);
}
