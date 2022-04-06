package com.example.projectkotlin.controller

import com.example.projectkotlin.service.AuthService
import com.example.projectkotlin.User
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody


@RestController
class AuthController @Autowired constructor(private val service: AuthService) {

    @PostMapping("/auth")
    fun authenticateUser(@RequestBody user: User): ResponseEntity<String>{
        return if (service.auth(user.login, user.password)) {
            ResponseEntity("Success!", HttpStatus.OK)
        } else {
            ResponseEntity("Auth error", HttpStatus.UNAUTHORIZED)
        }
    }
}