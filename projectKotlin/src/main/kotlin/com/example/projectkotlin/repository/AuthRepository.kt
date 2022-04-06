package com.example.projectkotlin.repository

import org.springframework.stereotype.Repository

@Repository
class AuthRepository {

    val usersMap = mutableMapOf("login1" to "password1", "ala" to "makota", "adam" to "kowalski")

    fun isExist(login: String, password: String): Boolean {
        if (usersMap.containsKey(login)){
            return usersMap[login].equals(password)
        }
        return false
    }
}