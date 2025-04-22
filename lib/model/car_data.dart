class CarData {
  int? carSpeed;
  String? currentCarGear;
  double? fuelLevel;
  bool? fuelLevelLow;
  bool? parkingBrake;
  bool? hazardLights;
  bool? highBeamLights;
  bool? headLights;

  CarData(
      {this.carSpeed,
        this.currentCarGear,
        this.fuelLevel,
        this.fuelLevelLow,
        this.parkingBrake,
        this.hazardLights,
        this.highBeamLights,
        this.headLights});

  CarData.fromJson(Map<String, dynamic> json) {
    carSpeed = json['carSpeed'];
    currentCarGear = json['currentCarGear'];
    fuelLevel = json['fuelLevel'];
    fuelLevelLow = json['fuelLevelLow'];
    parkingBrake = json['parkingBrake'];
    hazardLights = json['hazardLights'];
    highBeamLights = json['highBeamLights'];
    headLights = json['headLights'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carSpeed'] = carSpeed;
    data['currentCarGear'] = currentCarGear;
    data['fuelLevel'] = fuelLevel;
    data['fuelLevelLow'] = fuelLevelLow;
    data['parkingBrake'] = parkingBrake;
    data['hazardLights'] = hazardLights;
    data['highBeamLights'] = highBeamLights;
    data['headLights'] = headLights;
    return data;
  }
}