package com.example.fluttersample.data

import android.car.Car
import android.car.VehicleAreaType
import android.car.VehiclePropertyIds
import android.car.hardware.CarPropertyValue
import android.car.hardware.property.CarPropertyManager
import android.util.Log
import androidx.annotation.RequiresPermission
import com.example.fluttersample.util.GearType
import io.reactivex.Observable
import io.reactivex.subjects.PublishSubject
import io.reactivex.subjects.Subject

class CarManager(private val car: Car) {

    private val carPropertyManager by lazy { car.getCarManager(Car.PROPERTY_SERVICE) as CarPropertyManager }

    var carDataModel = CarData()

    private val carData: Subject<CarData> by lazy { PublishSubject.create() }
    val carDataObservable: Observable<CarData>
        get() = carData

    @RequiresPermission(
        allOf = [
            "android.car.permission.CAR_POWERTRAIN",
            "android.car.permission.CAR_SPEED",
            "android.car.permission.CAR_ENERGY",
            "android.car.permission.CAR_ENERGY_PORTS"
        ]
    )
    fun init() {
        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.FUEL_LEVEL,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )
        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.FUEL_LEVEL_LOW,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )
        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.PERF_VEHICLE_SPEED,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )
        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.GEAR_SELECTION,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )

        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.PARKING_BRAKE_ON,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )

        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.HAZARD_LIGHTS_STATE,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )
        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.HIGH_BEAM_LIGHTS_STATE,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )
        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.HEADLIGHTS_STATE,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )

        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.TIRE_PRESSURE,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )

        carPropertyManager.registerCallback(
            carPropertyCallback,
            VehiclePropertyIds.IGNITION_STATE,
            CarPropertyManager.SENSOR_RATE_NORMAL
        )
    }

    fun cleanCallback() {
        carPropertyManager.unregisterCallback(carPropertyCallback)
    }

    private val carPropertyCallback = object : CarPropertyManager.CarPropertyEventCallback {
        override fun onChangeEvent(carPropertvalue: CarPropertyValue<*>?) {
            when (carPropertvalue?.propertyId) {
                VehiclePropertyIds.FUEL_LEVEL -> {
                    val fuelPercent = (carPropertvalue.value as Float) * 100 / getFuelCapacity()
                    carDataModel = carDataModel.copy(fuelLevel = fuelPercent)
                    carData.onNext(carDataModel)
                }

                VehiclePropertyIds.FUEL_LEVEL_LOW -> {
                    val fuelLevelLow = (carPropertvalue.value as Boolean)
                    carDataModel = carDataModel.copy(fuelLevelLow = fuelLevelLow)
                    carData.onNext(carDataModel)
                }
                VehiclePropertyIds.PERF_VEHICLE_SPEED -> {
                    // convert speed from sensor (m/s) to (km/h)
                    val speedKmH = (carPropertvalue.value as Float) * 3600 / 1000
                    carDataModel = carDataModel.copy(carSpeed = speedKmH.toInt())
                    carData.onNext(carDataModel)
                }

                VehiclePropertyIds.GEAR_SELECTION -> {
                    val gear = GearType.forType(carPropertvalue.value as Int)
                    carDataModel = carDataModel.copy(currentCarGear = gear)
                    carData.onNext(carDataModel)
                }
                VehiclePropertyIds.PARKING_BRAKE_ON -> {
                    val parkingBrake = (carPropertvalue.value as Boolean)
                    carDataModel = carDataModel.copy(parkingBrake = parkingBrake)
                    carData.onNext(carDataModel)
                }
                VehiclePropertyIds.HAZARD_LIGHTS_STATE -> {
                    val hazardLights = (carPropertvalue.value as Boolean)
                    carDataModel = carDataModel.copy(hazardLights = hazardLights)
                    carData.onNext(carDataModel)
                }
                VehiclePropertyIds.HIGH_BEAM_LIGHTS_STATE -> {
                    val highBeamLights = (carPropertvalue.value as Boolean)
                    carDataModel = carDataModel.copy(highBeamLights = highBeamLights)
                    carData.onNext(carDataModel)
                }
                VehiclePropertyIds.HEADLIGHTS_STATE -> {
                    Log.d("MyTag","HEADLIGHTS_STATE::${carPropertvalue.value}")
                    val headLights = (carPropertvalue.value as Boolean)
                    carDataModel = carDataModel.copy(headLights = headLights)
                    carData.onNext(carDataModel)
                }
                VehiclePropertyIds.TIRE_PRESSURE -> {
                    Log.d("MyTag","TIRE_PRESSURE::${carPropertvalue.value}")
                }
                VehiclePropertyIds.IGNITION_STATE -> {
                    Log.d("MyTag","IGNITION_STATE::${carPropertvalue.value}")
                }
            }
        }

        override fun onErrorEvent(p0: Int, p1: Int) = Unit
    }

    @RequiresPermission(allOf = ["android.car.permission.CAR_INFO"])
    fun getFuelCapacity(): Float {
        return getCarPropertyValue(
            VehiclePropertyIds.INFO_FUEL_CAPACITY,
            VehicleAreaType.VEHICLE_AREA_TYPE_GLOBAL
        )
    }

    private inline fun <reified T> getCarPropertyValue(carPropertyId: Int, carAreaType: Int): T {
        return carPropertyManager.getProperty<T>(carPropertyId, carAreaType).value
    }
}