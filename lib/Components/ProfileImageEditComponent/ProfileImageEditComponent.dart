import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forutonafront/Components/ProfileImageEditComponent/ImageSelectModalBottomSheet.dart';
import 'package:provider/provider.dart';

class ProfileImageEditComponent extends StatelessWidget {

  final ProfileImageEditComponentController profileImageEditComponentController;

  const ProfileImageEditComponent({Key key, this.profileImageEditComponentController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ProfileImageEditComponentViewModel(profileImageEditComponentController: profileImageEditComponentController),
        child: Consumer<ProfileImageEditComponentViewModel>(
            builder: (_, model, child) {
          return Container(
              constraints: BoxConstraints(
                  maxHeight: 230,
                  maxWidth: MediaQuery.of(context).size.width,
                  minHeight: 0,
                  minWidth: 0),
              decoration: BoxDecoration(color: Color(0xffF4F5F5)),
              child: Stack(fit: StackFit.expand, children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      model.showBackGroundImageModalBottomSheet(context);
                    },
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: 230,
                          maxWidth: MediaQuery.of(context).size.width,
                          minHeight: 0,
                          minWidth: 0),
                      decoration: model._backgroundImageProvider != null
                          ? BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: model._backgroundImageProvider,
                              ))
                          : BoxDecoration(
                              color: Colors.transparent,
                            ),
                    ),
                  ),
                ),
                Positioned(
                    top: 16,
                    right: 16,
                    child: InkWell(
                      onTap: () {
                        model.showBackGroundImageModalBottomSheet(context);
                      },
                      child: SvgPicture.asset(
                        "assets/IconImage/image-add.svg",
                        color: Color(0xffD4D4D4),
                      ),
                    )),
                Center(
                    child: Stack(children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        model.showProfileSelectImageModalBottomSheet(context);
                      },
                      child: model._profileImageProvider != null
                          ? Container(
                              width: 74,
                              height: 74,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: model._profileImageProvider,
                                  ),
                                  shape: BoxShape.circle),
                            )
                          : SvgPicture.asset(
                              "assets/IconImage/user-circle.svg",
                              height: 74,
                              width: 74,
                              color: Color(0xffD4D4D4),
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: 23,
                          height: 23,
                          decoration: BoxDecoration(
                              color: Color(0xffB1B1B1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xffF2F0F1), width: 1)),
                          child: Center(
                            child: SvgPicture.asset(
                                "assets/IconImage/pencil.svg",
                                color: Colors.white,
                                width: 10,
                                height: 10),
                          )))
                ]))
              ]));
        }));
  }
}

class ProfileImageEditComponentViewModel extends ChangeNotifier {

  ProfileImageEditComponentController profileImageEditComponentController;

  FileImage _profileImageProvider;

  FileImage _backgroundImageProvider;

  ImageSelectModalBottomSheet _imageProfileSelectModalBottomSheet;

  ImageSelectModalBottomSheet _imageBackGroundSelectModalBottomSheet;

  ProfileImageEditComponentViewModel({this.profileImageEditComponentController}) {
    _imageProfileSelectModalBottomSheet =
        ImageSelectModalBottomSheet(onSelectImage: onProfileSelectImage);
    _imageBackGroundSelectModalBottomSheet =
        ImageSelectModalBottomSheet(onSelectImage: onBackgroundSelectImage);
    profileImageEditComponentController._profileImageEditComponentViewModel = this;
  }

  showProfileSelectImageModalBottomSheet(BuildContext context) {
    _imageProfileSelectModalBottomSheet.show(context, "프로필 이미지 변경");
  }

  onProfileSelectImage(FileImage imageProvider) {
    _profileImageProvider = imageProvider;
    notifyListeners();
  }

  showBackGroundImageModalBottomSheet(BuildContext context) {
    _imageBackGroundSelectModalBottomSheet.show(context, "배경화면 이미지 변경");
  }

  onBackgroundSelectImage(FileImage imageProvider) {
    _backgroundImageProvider = imageProvider;
    notifyListeners();
  }
}

class ProfileImageEditComponentController {
  ProfileImageEditComponentViewModel _profileImageEditComponentViewModel;

  FileImage getProfileImageProvider(){
    return _profileImageEditComponentViewModel._profileImageProvider;
  }

  FileImage getBackgroundImageProvider(){
    return _profileImageEditComponentViewModel._backgroundImageProvider;
  }

}