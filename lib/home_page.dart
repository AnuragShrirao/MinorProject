import 'package:flutter/material.dart';
import 'package:prediction/prediction.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double techSkills = 0;
  double communicationSkill = 0;
  TextEditingController name = TextEditingController();
  TextEditingController percentage = TextEditingController();
  TextEditingController backlog = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Placement Prediction Project"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            oneRow(
              text: "Name",
              name: name,
              inputDecoration: InputDecoration(hintText: "Enter Your Name"),
            ),
            oneRow(
              text: "Roll No",
              name: null,
              inputDecoration: InputDecoration(hintText: "Enter Your Roll No"),
            ),
            oneRow(
              text: "Aggregate (%)",
              name: percentage,
              inputDecoration:
                  InputDecoration(hintText: "Enter Your Aggregate"),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 20.0, bottom: 10),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Text(
                    "Technical Skills(0-10) : ",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    techSkills.toString(),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
            Slider(
              value: techSkills,
              min: 0,
              max: 10,
              divisions: 10,
              label: techSkills.round().toString(),
              activeColor: Colors.orangeAccent,
              onChanged: (double value) {
                setState(() {
                  techSkills = value;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 25.0, right: 25.0, top: 20.0, bottom: 10),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Text(
                    "Communication Skills(0-10) : ",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    communicationSkill.toString(),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
            Slider(
              value: communicationSkill,
              min: 0,
              max: 10,
              divisions: 10,
              label: communicationSkill.round().toString(),
              activeColor: Colors.orangeAccent,
              onChanged: (double value) {
                setState(() {
                  communicationSkill = value;
                });
              },
            ),

            oneRow(
              text: "Backlog",
              name: backlog,
              inputDecoration: InputDecoration(hintText: "No of backlog"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    Prediction model = Prediction();

                    await model.getPlacementPrediction(
                            aggregate: int.parse(percentage.text),
                            technical: techSkills.round().toInt(),
                            communication: communicationSkill.round().toInt(),
                            backlogs: int.parse(backlog.text))
                        .then((value) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                content: value == "1"
                                    ? Text(
                                        "You might get placed",
                                        style: TextStyle(color: Colors.green),
                                      )
                                    : Text(
                                        "You Might not get placed",
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                title: Text("Hi, " + name.text + "!!!"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK"))
                                ],
                              ));
                    });
                  },
                  child: Text("PREDICT")),
            )
          ],
        ),
      ),
    );
  }

  Wrap sliderRow({String name, double value}) {
    return Wrap(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0, bottom: 10),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(
                name,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(
                value.toString(),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent),
              ),
            ],
          ),
        ),
        Slider(
          value: value,
          min: 0,
          max: 10,
          divisions: 10,
          label: value.round().toString(),
          activeColor: Colors.orangeAccent,
          onChanged: (double value) {
            setState(() {
              value = value;
            });
          },
        ),
      ],
    );
  }

  Wrap oneRow(
      {TextEditingController name,
      InputDecoration inputDecoration,
      String text}) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    text,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  decoration: inputDecoration,
                  controller: name,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
