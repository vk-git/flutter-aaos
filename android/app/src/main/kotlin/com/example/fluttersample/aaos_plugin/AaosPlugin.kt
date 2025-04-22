package com.example.fluttersample.aaos_plugin

import android.car.Car
import android.content.Context
import android.media.session.PlaybackState
import android.os.Build
//import android.support.v4.media.session.MediaSessionCompat
//import android.support.v4.media.session.PlaybackStateCompat
import android.util.Log
import androidx.core.app.ActivityCompat
import com.example.fluttersample.data.CarManager
import com.example.fluttersample.ext.hasPermissions
import com.example.fluttersample.ext.toMap
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import io.reactivex.disposables.CompositeDisposable

class AaosPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {

    companion object {
        private val PERMISSION = arrayOf(
            "android.car.permission.CAR_EXTERIOR_ENVIRONMENT",
            "android.car.permission.CAR_POWERTRAIN",
            "android.car.permission.CAR_SPEED",
            "android.car.permission.CAR_ENERGY",
            "android.car.permission.CAR_ENERGY_PORTS",
            "android.car.permission.CAR_INFO"
        )
    }

    private var methodChannel: MethodChannel? = null
    private var channel: EventChannel? = null
    private var flutterPluginBinding: FlutterPluginBinding? = null
    private var activityPluginBinding: ActivityPluginBinding? = null

    private val compositeDisposable = CompositeDisposable()
    private var carManager: CarManager? = null

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        this.flutterPluginBinding = binding
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        this.flutterPluginBinding = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityPluginBinding = binding
        flutterPluginBinding?.let { flutterPluginBinding ->
            setupChannels(
                flutterPluginBinding.applicationContext,
                flutterPluginBinding.binaryMessenger
            )
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        teardownEventChannels()
    }

    private fun teardownEventChannels() {
        compositeDisposable.dispose()
        methodChannel?.setMethodCallHandler(null)
        channel?.setStreamHandler(null)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result,
    ) {
        if (call.method == "getPlatformVersion") {
            result.success("Android" + Build.VERSION.RELEASE)
        } else {
            result.notImplemented()
        }
    }

    private fun setupChannels(context: Context, messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, "aaos_plugin")
        methodChannel?.setMethodCallHandler(this)

        channel = EventChannel(messenger, "CarData")

        activityPluginBinding?.addRequestPermissionsResultListener(object : RequestPermissionsResultListener {
            override fun onRequestPermissionsResult(
                requestCode: Int,
                permissions: Array<out String?>,
                grantResults: IntArray
            ): Boolean {
                val result = activityPluginBinding?.activity?.hasPermissions(PERMISSION) == true
                if (result) {
                    checkPermission(context)
                }
                return true
            }
        })

        checkPermission(context)


    }

    private fun checkPermission(context: Context) {
        activityPluginBinding?.let { activityPluginBinding ->
            if (activityPluginBinding.activity.hasPermissions(PERMISSION)) {
                val car = Car.createCar(context)
                carManager = CarManager(car)
                eventObserver()
                carManager?.init()
            } else {
                requestPermission()
            }
        }
    }

    private fun requestPermission() {
        activityPluginBinding?.let { activityPluginBinding ->
            ActivityCompat.requestPermissions(
                activityPluginBinding.activity, PERMISSION, 0
            )
        }
    }

    private fun eventObserver() {
        channel?.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onCancel(arguments: Any?) {
                carManager?.cleanCallback()
            }

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                carManager?.let { carManager ->
                    compositeDisposable.add(
                        carManager.carDataObservable
                            .subscribe({
                                events?.success(it.toJson().toMap())
                            }, {
                                events?.error("ERROR-01", "${it.message}", it.cause?.message)
                            })
                    )
                }
            }
        })
    }
}