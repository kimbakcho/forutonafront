import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class KCodeTopFilterBar extends StatelessWidget {
  final String searchText;
  final String descriptionText;

  final KCodeTopFilterBarController kCodeTopFilterBarController;

  const KCodeTopFilterBar(
      {Key key,
      this.searchText,
      this.descriptionText,
      this.kCodeTopFilterBarController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => KCodeTopFilterBarViewModel(
          kCodeTopFilterBarController: kCodeTopFilterBarController
        ),
        child: Consumer<KCodeTopFilterBarViewModel>(
          builder: (_, model, __) {
            return Row(children: [
              Container(
                child: Text("\"$searchText\" ",
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
                child: Text("(${model._searchResultCountText})",
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xff454f63),
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Spacer(),
              RawMaterialButton(
                constraints: BoxConstraints(minWidth: 0,minHeight: 0),
                onPressed: () {
                  model.openFilter();
                },
                child: Icon(Icons.filter),
              )
            ]);
          },
        ));
  }
}

class KCodeTopFilterBarViewModel extends ChangeNotifier {
  final KCodeTopFilterBarController kCodeTopFilterBarController;
  String _searchResultCountText = "";

  KCodeTopFilterBarViewModel({this.kCodeTopFilterBarController}) {
    kCodeTopFilterBarController._kCodeTopFilterBarViewModel = this;
  }


  setSearchResultCountText(String text){
    this._searchResultCountText = text;
    notifyListeners();
  }

  void openFilter() {
    if(kCodeTopFilterBarController != null){
      kCodeTopFilterBarController.onFilter();
    }
  }

}

class KCodeTopFilterBarController {
  KCodeTopFilterBarViewModel _kCodeTopFilterBarViewModel;
  Function onFilter;


  KCodeTopFilterBarController({this.onFilter});

  void setSearchResultCountText(String text){
    _kCodeTopFilterBarViewModel.setSearchResultCountText(text);
  }

}
