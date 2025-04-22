package com.example.fluttersample.ext

import org.json.JSONArray
import org.json.JSONObject

fun JSONObject.toMap(): Map<String, Any> {
    val map = mutableMapOf<String, Any>()
    for (key in keys()) {
        if (!isNull(key)) {
            map[key] = unwrapJSON(get(key))
        }
    }
    return map
}

private fun unwrapJSON(value: Any) = when (value) {
    is JSONObject -> value.toMap()
    is JSONArray -> value.toList()
    else -> value
}

fun JSONArray.toList(): List<Any> {
    val list = mutableListOf<Any>()
    for (i in 0 until length()) {
        list.add(unwrapJSON(get(i)))
    }
    return list
}