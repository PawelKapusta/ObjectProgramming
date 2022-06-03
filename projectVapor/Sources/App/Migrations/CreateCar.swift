import Fluent

struct CreateCar: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("cars")
            .id()
            .field("name", .string, .required)
            .field("price", .string, .required)
            .field("weight", .string, .required)
            .field("brand_id", .uuid, .references("brands", "id"))
            .foreignKey("brand_id", references: "brands", "id", onDelete: .cascade)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("cars").delete()
    }
}
