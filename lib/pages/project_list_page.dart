import 'package:flutter/material.dart';
import '../models/project_model.dart';

class ProjectListPage extends StatefulWidget {
  @override
  _ProjectListPageState createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  String text = "Loading";
  List<ProjectModel> listProject = new List<ProjectModel>();

/*
for demo hardcode
 */
  void _populateProjectData() {
    listProject.add(new ProjectModel(
        "assets/images/1.jpg", "Michale Buble - Everthing", "Jova Music"));
    listProject.add(new ProjectModel(
        "assets/images/2.jpg", "Lately - Stevie Wonders Part 2", "Jova Music"));
    listProject.add(new ProjectModel(
        "assets/images/3.jpg", "Lately - Stevie Wonders Part 3", "Jova Music"));
    listProject.add(new ProjectModel(
        "assets/images/1.jpg", "Lately - Stevie Wonders Part 4", "Jova Music"));
    listProject.add(new ProjectModel(
        "assets/images/2.jpg", "Lately - Stevie Wonders Part 5", "Jova Music"));
    listProject.add(new ProjectModel(
        "assets/images/3.jpg", "Lately - Stevie Wonders Part 6", "Jova Music"));
    listProject.add(new ProjectModel(
        "assets/images/1.jpg", "Michale Buble - Everthing", "Jova Music"));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _populateProjectData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(title: new Text("Project List")),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new ListView.builder(
                  itemCount: listProject.length,
                  itemBuilder: (BuildContext context, int index) {
                    return row(context, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget row(BuildContext context, int index) {
    return new Column(
      children: <Widget>[
        new Container(
          height: 150.0,
          margin:
              EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  begin: Alignment.bottomCenter,
                  colors: [const Color(0xFFCCCCCC), const Color(0xFFFFFFFF)],
                  end: Alignment.topCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.repeated),
              shape: BoxShape.rectangle,
              image: new DecorationImage(
                fit: BoxFit.none,
                image: new AssetImage(listProject.elementAt(index).linkImage),
              )),
        ),
        new Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          alignment: Alignment.topLeft,
          child: new Text(listProject.elementAt(index).titleProject,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              )),
        ),
        new Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          alignment: Alignment.topLeft,
          child: new Text(listProject.elementAt(index).vendorName,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }
}
