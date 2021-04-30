
import 'package:firebase_core/firebase_core.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class BallImageListUpLoadUseCaseInputPort {
  Future<List<BallImageItem?>> ballImageListUpLoadAndFillUrls(List<BallImageItem?> refSrcList);
}
@LazySingleton(as: BallImageListUpLoadUseCaseInputPort)
class BallImageListUpLoadUseCase implements BallImageListUpLoadUseCaseInputPort {

  final FBallRepository _fBallRepository;

  BallImageListUpLoadUseCase({required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<List<BallImageItem?>> ballImageListUpLoadAndFillUrls(List<BallImageItem?> refSrcList) async{
    var list = refSrcList.map((e) {
      if(e != null){
        return e.imageByte;
      }else {
        return null;
      }
    }).toList();

    for (int i = 0; i < refSrcList.length; i++) {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('/ballImage')
          .child('${Uuid().v4()}.jpg');
      var item = refSrcList[i];
      if(item != null ){
        var imageByte2 = item.imageByte;
        if(imageByte2 != null){
          var putData = ref.putData(imageByte2);
          var taskSnapshot = await putData.whenComplete(() => null);
          item.imageUrl = await taskSnapshot.ref.getDownloadURL();
        }
      }
    }
    return refSrcList;
  }

}