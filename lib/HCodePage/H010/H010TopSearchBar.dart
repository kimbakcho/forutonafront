import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BackButton/BorderCircleBackButton.dart';
import 'package:provider/provider.dart';
import '../../Components/AddressInputSearchBar/AddressInputSearchBar.dart';
import 'H010MainView.dart';

class H010TopSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xffF2F0F1)))
      ),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: [
          BorderCircleBackButton(),
          SizedBox(width: 16,),
          Expanded(
            child: AddressInputSearchBar(
              readOnly: false,
              autoFocusFlag: true,
              listener: Provider.of<H010MainViewModel>(context),
              initText: "",
            ),
          )
        ],
      ),
    );
  }
}


