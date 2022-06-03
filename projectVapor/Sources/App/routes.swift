import Fluent
import Vapor

func routes(_ app: Application) throws {

    app.get { req in
        return req.view.render("index", ["title": "Hello Vapor app!"])
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    let customerController = CustomerController()

    app.get("customers", use: customerController.read)
    
    app.post("customer", "create", use: customerController.create)
    app.post("customer", "update", ":id", use: customerController.update)
    app.post("customer", "delete", ":id", use: customerController.delete)
    
    let brandController = BrandController()
    
    app.get("brands", use: brandController.read)
    
    app.post("brand", "create", use: brandController.create)
    app.post("brand", "update", ":id", use: brandController.update)
    app.post("brand", "delete", ":id", use: brandController.delete)


    let carController = CarController()

    app.get("cars", use: carController.read)
    
    app.post("car", "create", use: carController.create)
    app.post("car", "update", ":id", use: carController.update)
    app.post("car", "delete", ":id", use: carController.delete)

}

// https://docs.vapor.codes/4.0/routing/
