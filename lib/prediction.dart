import 'package:flutter/cupertino.dart';
import 'package:prediction/networking.dart';

const URL = "https://placement-fastapi.herokuapp.com/predict";

class Prediction {
  Future<dynamic> getPlacementPrediction(
      {@required int aggregate,
      @required int technical,
      @required int communication,
      @required int backlogs}) async {
    NetworkHelper networkHelper = NetworkHelper(URL);
    var data = await networkHelper.getData(
        aggregate: aggregate,
        technical: technical,
        communication: communication,
        backlogs: backlogs);
    return data;
  }
}
