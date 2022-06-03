//
//  File.swift
//  
//
//  Created by Paweł Kapusta
//
import Vapor
import Fluent

final class Customer: Model, Content {
    static let schema = "customers"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "first_name")
    var first_name: String
    @Field(key: "last_name")
    var last_name: String
    @Field(key: "email")
    var email: String
    init() { }

    init(id: UUID? = nil, first_name: String, last_name: String, email: String ) {
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
    }
}
