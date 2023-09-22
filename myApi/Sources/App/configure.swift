import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Create data base "users.db"
    app.databases.use(.sqlite(.file("users.db")), as: .sqlite)

    //  do migrations 
    app.migrations.add(CreateUserInfo())

    // register routes
    try routes(app)
}
