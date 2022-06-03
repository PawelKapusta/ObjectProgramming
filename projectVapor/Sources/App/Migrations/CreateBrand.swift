import Fluent

struct CreateBrand: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("brands")
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("brands").delete()
    }
}
