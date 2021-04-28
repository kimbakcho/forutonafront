
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';


import 'package:injectable/injectable.dart';

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

    var fBallImageUploadResDto =
        await _fBallRepository.ballImageUpload(images: list);

    for (int i = 0; i < fBallImageUploadResDto.urls!.length; i++) {
      refSrcList[i].imageUrl = fBallImageUploadResDto.urls![i];
    }

    return refSrcList;
  }

}