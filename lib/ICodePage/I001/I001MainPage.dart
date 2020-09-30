import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/TopH_I_001NavExpendAniContent.dart';
import 'package:provider/provider.dart';

class I001MainPage extends StatefulWidget {

  const I001MainPage({Key key})
      : super(key: key);

  @override
  _I001MainPageState createState() => _I001MainPageState();
}

class _I001MainPageState extends State<I001MainPage>
    with WidgetsBindingObserver {
  UniqueKey googleMapKey = UniqueKey();

  _I001MainPageState();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    googleMapKey = UniqueKey();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>I001MainPageViewModel(),
      child: Consumer<I001MainPageViewModel>(
        builder: (_,model,__){
          return Container(
            child: Text("123"),
          );
        },
      )
    ) ;
  }
}

class I001MainPageViewModel extends ChangeNotifier {

  // ignore: non_constant_identifier_names
  I001MainPageViewModel();
}