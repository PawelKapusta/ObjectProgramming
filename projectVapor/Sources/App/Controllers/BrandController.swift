//
//  File.swift
//  
//
//  Created by Paweł Kapusta
//
import Fluent
import Vapor


struct BrandController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {}

    func create(req: Request) throws -> EventLoopFuture<Response> {
        let brand = try req.content.decode(Brand.self)
        return brand.save(on: req.db).map { _ in
            return req.redirect(to: "/brands")
        }
    }

    func read(_ req: Request) throws -> EventLoopFuture<View> {
        let brands = Brand.query(on: req.db).all()
        return brands.flatMap { all in
            let data = ["brandsList": all]
            return req.view.render("brands", data)
        }
    }

    func update(req: Request) throws -> EventLoopFuture<Response> {
        let newData = try req.content.decode(Brand.self)
        return Brand.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { brand in
                brand.name = newData.name
                brand.description = newData.description
                return brand.save(on: req.db).map { _ in
                    return req.redirect(to: "/brands")
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<Response> {
        return Brand.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { _ in
                return req.redirect(to: "/brands")
            }
    }
}
