//
//  File.swift
//  
//
//  Created by Paweł Kapusta
//
import Fluent
import Vapor


struct CustomerController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let customer = try req.content.decode(Customer.self)
        return customer.save(on: req.db).map { _ in
            return req.redirect(to: "/customers")
        }
    }

    func read(_ req: Request) throws -> EventLoopFuture<View> {
        let customers = Customer.query(on: req.db).all()
        return customers.flatMap { all in
            let data = ["customersList": all]
            return req.view.render("customers", data)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let newData = try req.content.decode(Customer.self)
        return Customer.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { customer in
                customer.first_name = newData.first_name
                customer.last_name = newData.last_name
                customer.email = newData.email
                return customer.save(on: req.db).map { _ in
                    return req.redirect(to: "/customers")
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Customer.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/customers")
            }
    }
}
