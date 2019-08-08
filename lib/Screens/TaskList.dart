import 'package:flutter/material.dart';

//Common Dart File
import 'package:progressclubsurat/Common/Constants.dart' as cnst;
import 'package:progressclubsurat/Common/Services.dart';
import 'package:progressclubsurat/Component/LoadinComponent.dart';
import 'package:progressclubsurat/Component/NoDataComponent.dart';

//Components Dart File
import 'package:progressclubsurat/Component/TaskComponents.dart';
import 'package:progressclubsurat/Component/PendingAssignmentComponents.dart';
import 'package:progressclubsurat/Component/CompletedComponents.dart';

class TaskList extends StatefulWidget {
  TextEditingController edtName = new TextEditingController();

  var list;
  String meetingId;

  TaskList({Key key, this.list, this.meetingId}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: cnst.appPrimaryMaterialColor,
          ),
        ),
        actionsIconTheme: IconThemeData.fallback(),
        title: Text(
          'Task List',
          style: TextStyle(
              color: cnst.appPrimaryMaterialColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),

      */ /*body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: ListView.builder(
              padding: EdgeInsets.only(top: 5),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return TaskComponents();
              }),
        ),
      ),*/ /*


    );*/

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: cnst.appPrimaryMaterialColor,
        accentColor: Colors.white,
        buttonColor: Colors.deepPurple,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Pending',
                  ),
                ),
                Tab(
                  child: Text('Completed'),
                ),
              ],
            ),
            title: Text(
              'Task List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: widget.list["PendingAssignment"].length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.only(top: 5),
                        itemCount: widget.list["PendingAssignment"].length,
                        itemBuilder: (BuildContext context, int index) {
                          return PendingAssignmentComponents(
                              widget.list["PendingAssignment"][index],widget.meetingId);
                        })
                    : NoDataComponent(),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List>(
                  future: Services.getCompletedAssi(widget.meetingId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? snapshot.data.length > 0
                            ? ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CompletedComponents(
                                      snapshot.data[index]);
                                },
                              )
                            : NoDataComponent()
                        : LoadinComponent();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
