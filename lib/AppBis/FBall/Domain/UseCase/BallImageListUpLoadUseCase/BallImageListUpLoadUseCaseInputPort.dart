
import 'package:firebase_core/firebase_core.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class BallImageListUpLoadUseCaseInputPort {
  Future<List<BallImageItem>> ballImageListUpLoadAndFillUrls(List<BallImageItem> refSrcList);
}
@LazySingleton(as: BallImageListUpLoadUseCaseInputPort)
class BallImageListUpLoadUseCase implements BallImageListUpLoadUseCaseInputPort {

  final FBallRepository _fBallRepository;

  BallImageListUpLoadUseCase({required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<List<BallImageItem>> ballImageListUpLoadAndFillUrls(List<BallImageItem> refSrcList) async{
    var list = refSrcList.map((e) => e.imageByte).toList();

    for (int i = 0; i < refSrcList.length; i++) {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('/ballImage')
          .child('${Uuid().v4()}.jpg');
      var putData = ref.putData(refSrcList[i].imageByte);
      var taskSnapshot = await putData.whenComplete(() => null);

      refSrcList[i].imageUrl = await taskSnapshot.ref.getDownloadURL();
    }
    return refSrcList;
  }

}