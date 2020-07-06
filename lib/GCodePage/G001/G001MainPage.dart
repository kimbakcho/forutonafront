import 'package:flutter/material.dart';
import 'package:forutonafront/GCodePage/G001/G001MainPageViewModel.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class G001MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        create: (_) => G001MainPageViewModel(
            context: context,
            signInUserInfoUseCaseInputPort: sl(),
            authUserCaseInputPort: sl()),
        child: Consumer<G001MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    child: Stack(children: <Widget>[
              Positioned(
                  top: 36,
                  width: MediaQuery.of(context).size.width,
                  child: userProfileImage(model)),
              Positioned(
                  top: 126,
                  width: MediaQuery.of(context).size.width,
                  child: userNickName(model)),
              Positioned(
                top: 151,
                width: MediaQuery.of(context).size.width,
                child: userCountry(model),
              ),
              Positioned(
                  top: 179,
                  width: MediaQuery.of(context).size.width,
                  child: userIntroduce(model)),
            ])))
          ]);
        }));
  }

  Row userIntroduce(G001MainPageViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            child: model.haveUserSelfIntroduction()
                ? Text(model.getUserSelfIntroduction(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: Color(0xff454F63),
                    ))
                : Container(
                    child: InkWell(
                        onTap: () {},
                        child: Text(model.getUserSelfIntroduction(),
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              color: Color(0xff3497fd),
                              decoration: TextDecoration.underline,
                            ))))),
      ],
    );
  }

  Row userCountry(G001MainPageViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(model.getUserCountry(),
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xff454f63),
              )),
        ),
      ],
    );
  }

  Row userNickName(G001MainPageViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            child: Text(model.getUserNickName(),
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xff454f63),
                ))),
      ],
    );
  }

  Row userProfileImage(G001MainPageViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 69.00,
            width: 69.00,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: model.getUserProfileImage(),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 3.00),
                    color: Color(0xff000000).withOpacity(0.16),
                    blurRadius: 6,
                  ),
                ],
                shape: BoxShape.circle)),
      ],
    );
  }
}
