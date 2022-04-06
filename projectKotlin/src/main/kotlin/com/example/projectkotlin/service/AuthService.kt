package com.example.projectkotlin.service

import com.example.projectkotlin.repository.AuthRepository
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
object AuthService {
    @Autowired
    private var authRepo = AuthRepository()

    fun auth(login: String, password: String): Boolean {
        return authRepo.isExist(login, password)
    }

}