import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectModalBottomSheet {

  final Function(FileImage?) onSelectImage;

  final Color color;

  final isShowBasicImageSelect;

  final _picker = ImagePicker();

  ImageSelectModalBottomSheet({required this.onSelectImage,this.color = Colors.transparent,this.isShowBasicImageSelect = true});

  show(BuildContext context,String label){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        builder: (_) {
          return Container(
              color:  color,
              height: isShowBasicImageSelect ? 270 : 240,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Text(label,
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff3a3e3f),
                            ))),
                    Divider(height: 1, color: Color(0xffE4E7E8)),
                    isShowBasicImageSelect ? ListTile(
                      title: Text("기본 이미지"),
                      onTap: () {
                        onSelectImage(null);
                      },
                    ): Container(),
                    ListTile(
                      title: Text("카메라"),
                      onTap: () async {
                        var pickedFile = await _picker.getImage(source: ImageSource.camera);
                        if(pickedFile != null){
                          var _image = File(pickedFile.path);
                          onSelectImage(FileImage(_image));
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: Text("갤러리"),
                      onTap: () async {
                        var pickedFile = await _picker.getImage(source: ImageSource.gallery);
                        if(pickedFile != null){
                          var _image = File(pickedFile.path);
                          onSelectImage(FileImage(_image));
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            color: Color(0xffE4E7E8),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "닫기",
                              style: GoogleFonts.notoSans(
                                fontSize: 16,
                                color: const Color(0xff2f3035),
                                fontWeight: FontWeight.w500,
                              ),
                            ))
                      ],
                    )
                  ]));
        });
  }
}