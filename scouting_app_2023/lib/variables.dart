import 'package:flutter/material.dart';

var rodAlone = const AssetImage('assets/images/thumbnail_rod.png');
var rodCone = const AssetImage('assets/images/thumbnail_rodcone.png');
var platBlock = const AssetImage('assets/images/thumbnail_platblock.png');
var platAlone = const AssetImage('assets/images/thumbnail_plat.png');
var floorAlone = const AssetImage('assets/images/thumbnail_empty.png');
var floorCargo = const AssetImage('assets/images/thumbnail_floor.png');
var baseUser = "blankUsername";
var basePin = "blankPassword";

var buttonOneImage = rodAlone;
var buttonOneState = false;

var buttonTwoImage = platAlone;
var buttonTwoState = false;

var button3Image = rodAlone;
var button3State = false;

var button4Image = rodAlone;
var button4State = false;

var button5Image = platAlone;
var button5State = false;

var button6Image = rodAlone;
var button6State = false;

var button7Image = rodAlone;
var button7State = false;

var button8Image = platAlone;
var button8State = false;

var button9Image = rodAlone;
var button9State = false;

var button10Image = rodAlone;
var button10State = false;

var button11Image = platAlone;
var button11State = false;

var button12Image = rodAlone;
var button12State = false;

var button13Image = rodAlone;
var button13State = false;

var button14Image = platAlone;
var button14State = false;

var button15Image = rodAlone;
var button15State = false;

var button16Image = rodAlone;
var button16State = false;

var button17Image = platAlone;
var button17State = false;

var button18Image = rodAlone;
var button18State = false;

var button19Image = floorAlone;
var button19State = false;

var button20Image = floorAlone;
var button20State = false;

var button21Image = floorAlone;
var button21State = false;

var button22Image = floorAlone;
var button22State = false;

var button23Image = floorAlone;
var button23State = false;

var button24Image = floorAlone;
var button24State = false;

var button25Image = floorAlone;
var button25State = false;

var button26Image = floorAlone;
var button26State = false;

var button27Image = floorAlone;
var button27State = false;

var firebasePush = {};

var firebasePitPush = {};

var firebaseSSPush = {};

dynamic temprobotJson = {
  'startingPos': 'null',
  'pointsAverage': 'null',
  'chargingPoints': 'null',
  'driveTrain': 'null',
  'cargoTypes': 'null',
  'gripper': 'null',
  'ssnotes': 'null',
};

List<String> pageData = [
  '0', //[0]
  '0', //[1]
  '0', //[2]
  '0', //[3]
  '0', //[4]
  '0', //[5]
  '0', //[6]
  '0', //[7]
  '0', //[8]
  '0', //[9]
  '0', //[10]
  '0', //[11]
  '0', //[12]
  '0', //[13]
  '0', //[14]
  '0', //[15]
  '0', //[16]
  '0', //[17]
  '0', //[18]
  '0', //[19]
  '0', //[20]
  '0', //[21]
  '0', //[22]
  '0', //[23]
  '0', //[24]
  '0', //[25]
  '0', //[26]
  'StartingPosition', //[27]
  'ChargingStationAuto', //[28]
  'Community', //[29]
  'AutoScoring', //[30]
  'ChargingStationEndgame', //[31]
  'BotsOnChargingStation', //[32]
  'InsideOrOutsideCommunity', //[33]
  'Notes', //[34]
  'MatchNum', //[35]
  'RobotNum', //[36]
  'noUserSaved', //[37]
];

List<String> pitData = [
  'Drive Train', //0
  'Width', //1
  'Height', //2
  'Weight', //3
  'Cones/Cubes/Both/Neither', //4
  'How high?', //5
  'AutoBalance Auto?', //6
  'Team Friendliness', //7
];

List<String> ssData = [
  'Grip Strength',
  'Approach',
  'Scouter Notes',
];

var testVar = false;

var password = basePin;
