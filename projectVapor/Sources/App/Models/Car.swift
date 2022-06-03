//
//  File.swift
//  
//
//  Created by Paweł Kapusta
//

import Vapor
import Fluent

final class Car: Model, Content {
    static let schema = "cars"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    @Field(key: "price")
    var price: String
    @Field(key: "weight")
    var weight: String

    @Field(key: "brand_id")
    var brand_id: UUID

    init() { }

    init(id: UUID? = nil, name: String, price: String, weight: String) {
        self.id = id
        self.name = name
        self.price = price
        self.weight = weight
        self.brand_id = UUID(brand_id.uuidString)!
    }
}
