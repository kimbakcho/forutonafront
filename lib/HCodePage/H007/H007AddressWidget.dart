import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H010/H010MainView.dart';
import 'package:google_fonts/google_fonts.dart';

class H007AddressWidget extends StatelessWidget {
  final String address;

  const H007AddressWidget({
    Key key,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: MediaQuery.of(context).size.width - 136,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            settings: RouteSettings(name: "H010"),
            builder: (_)=> H010MainView()
          ));
        },
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Text(address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: const Color(0xff454f63),
              fontWeight: FontWeight.w700,
            )),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
    );
  }
}
