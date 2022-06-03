//
//  File.swift
//  
//
//  Created by Paweł Kapusta
//

import Fluent
import Vapor


struct CarController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let car = try req.content.decode(Car.self)
        return car.save(on: req.db).map { _ in
            return req.redirect(to: "/cars")
        }
    }

    func read(_ req: Request) throws -> EventLoopFuture<View> {
        let cars = Car.query(on: req.db).all()
        return cars.flatMap { all in
            let data = ["carsList": all]
            return req.view.render("cars", data)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let newData = try req.content.decode(Car.self)
        return Car.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { car in
                car.name = newData.name
                car.price = newData.price
                car.weight = newData.weight
                car.brand_id = newData.brand_id
                return car.save(on: req.db).map { _ in
                    return req.redirect(to: "/cars")
                }
            }
    }


    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Car.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/cars")
            }
    }
}
