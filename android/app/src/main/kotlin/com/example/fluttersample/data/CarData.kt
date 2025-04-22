package com.example.fluttersample.data

import org.json.JSONObject

data class CarData(
    var carSpeed: Int = 0,
    var currentCarGear: String = "",
    var fuelLevel: Float = 0.0F,
    var fuelLevelLow: Boolean = false,
    var parkingBrake: Boolean = true,
    var hazardLights: Boolean = false,
    var highBeamLights: Boolean = false,
    var headLights: Boolean = false,
) {
    fun toJson(): JSONObject {
        val json = JSONObject()
        json.put("carSpeed", carSpeed)
        json.put("currentCarGear", currentCarGear)
        json.put("fuelLevel", fuelLevel)
        json.put("fuelLevelLow", fuelLevelLow)
        json.put("parkingBrake", parkingBrake)
        json.put("hazardLights", hazardLights)
        json.put("highBeamLights", highBeamLights)
        json.put("headLights", headLights)
        return json
    }
}