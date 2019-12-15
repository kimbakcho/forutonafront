import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MutipleImageSelectView extends StatefulWidget {
  MutipleImageSelectView({Key key}) : super(key: key);

  @override
  _MutipleImageSelectViewState createState() => _MutipleImageSelectViewState();
}

class _MutipleImageSelectViewState extends State<MutipleImageSelectView> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {

      Navigator.pop(context, resultList);
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text(''),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }
}
