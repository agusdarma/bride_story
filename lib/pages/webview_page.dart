import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewPageState extends State<WebviewPage> {
  static const String ID = 'WebviewPageState';


  @override
  initState() {
    super.initState();
    var urlg = widget.url;
    // var urlg = "https://roundme.com/tour/291549/view/919147/";
    // https://goo.gl/maps/PhwemwnN3s62
    // https://www.google.com/maps/@-6.2265179,106.8468987,3a,75y,283.46h,98.51t/data=!3m7!1e1!3m5!1sAF1QipMwDllOGiiOBip0ilCoudHm4_B9LOYG2c3trwIW!2e10!3e12!7i5376!8i2688
    // var urlg = "https://www.detik.com/";
    print("url $urlg");
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      // url: "https://roundme.com/tour/291549/view/919147/",
      appBar: _createHeader(context),
      withJavascript: true,
      withLocalStorage: true,
      withZoom: true,
    );
  } // build

  Widget _createHeader(BuildContext context) {
    double fontSize = 12.0;
    AppBar appBar = new AppBar(
        title: new Center(
          child: new Text("4D Tour",
          style: TextStyle(
            fontSize: 14.0,           
          ))
//           new Image.asset('assets/images/1.jpg',
// //        width: 120.0,
//               height: 30.0,
//               fit: BoxFit.cover
//           ),
        ),
        // actions: <Widget>[
        //   new IconButton(
        //     icon: const Icon(Icons.home),
        //     tooltip: 'Back to Home',
        //     onPressed: () {
        //       //https://stackoverflow.com/questions/45889341/flutter-remove-all-routes?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
        //       // Navigator.pushNamedAndRemoveUntil(context, 'home', ModalRoute.withName('home'));
        //       Navigator.pop(context);
        //     },
        //   ),
        // ]
    );
    return appBar;
  }

}

class WebviewPage extends StatefulWidget {
  String url;

  WebviewPage({Key key,@required this.url}): super(key: key);

  @override
  State createState() => new WebviewPageState();
}