import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';
import 'package:http/http.dart' as http;

/// Custom image delegate used by this example to load image from application
/// assets.
class CustomImageDelegate implements ZefyrImageDelegate<ImageSource> {
  Fcube cube;
  CustomImageDelegate({this.cube});

  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await ImagePicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500);
    if (file == null) {
      return null;
    } else {
      print("cuberelationimageupload");
      String resulturl = await cuberelationimageupload(file);
      if (resulturl.length == 0) {
        return null;
      } else {
        return resulturl;
      }
    }
  }

  Future<String> cuberelationimageupload(File image) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var uploadurl = Preference.httpurlbase(
        Preference.baseBackEndUrl, '/api/v1/Fcube/cuberelationimageupload');
    var request = new http.MultipartRequest("POST", uploadurl);
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('CubeRelationImage', image.path);
    request.headers[HttpHeaders.authorizationHeader] = "Bearer " + token.token;
    request.files.add(multipartFile);
    request.fields["cubeuuid"] = cube.cubeuuid;
    StreamedResponse streamresponse = await request.send();
    Response response = await Response.fromStream(streamresponse);
    if (response.statusCode == 200) {
      var revlink = response.body;
      return revlink;
    } else {
      return "";
    }
  }

  static Future<int> cuberelationimagedelete(String urlpath) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/cuberelationimagedelete", {"url": urlpath});
    var response = await http.post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token.token});
    return int.tryParse(response.body);
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    // We use custom "asset" scheme to distinguish asset images from other files.
    if (key.startsWith('asset://')) {
      final asset = AssetImage(key.replaceFirst('asset://', ''));
      return Image(image: asset);
    } else if (key.startsWith('http')) {
      final image = NetworkImage(key);
      return Image(image: image);
    } else {
      // Otherwise assume this is a file stored locally on user's device.
      final file = File.fromUri(Uri.parse(key));
      final image = FileImage(file);
      return Image(image: image);
    }
  }
}
