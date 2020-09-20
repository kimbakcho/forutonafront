import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BallPositionInfoBar extends StatelessWidget {
  const BallPositionInfoBar({
    Key key,
    @required this.issueBallDisPlayUseCase,
    @required this.ballSearchPosition,
    @required this.gotoDetailPage,
  }) : super(key: key);
  final Position ballSearchPosition;
  final BallDisPlayUseCase issueBallDisPlayUseCase;
  final Function gotoDetailPage;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> BallPositionInfoBarViewModel(
        ballSearchPosition: ballSearchPosition,
          issueBallDisPlayUseCase: issueBallDisPlayUseCase),
      child: Consumer<BallPositionInfoBarViewModel>(
        builder: (_,model,__){
          return Container(
            padding: EdgeInsets.fromLTRB(12, 12, 9, 10),
            child: Material(
              child: InkWell(
                onTap: (){
                  gotoDetailPage();

                },
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(Icons.location_on,color: Color(0xff5B5B5B),size: 15,),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          issueBallDisPlayUseCase.placeAddress(),
                          style: GoogleFonts.notoSans(
                            fontSize: 13,
                            color: const Color(0xff5b5b5b),
                            letterSpacing: -0.26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      model.ballDistanceFromSearchPositionToText,
                      style: GoogleFonts.notoSans(
                        fontSize: 13,
                        color: const Color(0xff000000),
                        letterSpacing: -0.26,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
            )
            ,
          );
        }
      ),
    ) ;
  }
}
class BallPositionInfoBarViewModel extends ChangeNotifier implements BallDisPlayUseCaseOutputPort{
  String ballDistanceFromSearchPositionToText = "";
  final Position ballSearchPosition;
  final BallDisPlayUseCase issueBallDisPlayUseCase;

  BallPositionInfoBarViewModel({this.ballSearchPosition,this.issueBallDisPlayUseCase}){
    issueBallDisPlayUseCase.getDistanceFromSearchPositionToText(ballSearchPosition, this);
  }

  @override
  distanceFromSearchPositionToText(String distanceText) {
    ballDistanceFromSearchPositionToText = distanceText;
    notifyListeners();
  }

}