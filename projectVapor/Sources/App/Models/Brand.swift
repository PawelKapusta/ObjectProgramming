//
//  File.swift
//  
//
//  Created by Paweł Kapusta
//

import Vapor
import Fluent

final class Brand: Model, Content {
    static let schema = "brands"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    @Field(key: "description")
    var description: String


    init() { }

    init(id: UUID? = nil, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}

