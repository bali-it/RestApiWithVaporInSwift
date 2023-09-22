import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { _ in
        "It works!"
    }

    app.get("hello") { _ -> String in
        "Hello, world!"
    }

    // Parameters
    app.get("hello", ":name") { req -> String in
        let name = req.parameters.get("name")!
        req.logger.info("Hello, \(name) is calling")
        return "Hello, \(name)!"
    }

    // Catch all Params
    app.get("hello", "**") { req -> String in
        let name = req.parameters.getCatchall().joined(separator: " ")
        return "Hello, \(name)!"
    }

    app.get("number", ":x") { req -> String in
        guard let integer = req.parameters.get("x", as: Int.self) else {
            throw Abort(.badRequest)
        }
        return "\(integer) is great number!"
    }

    // Get All Credentails form database
    app.get("users") { req -> EventLoopFuture<[UserInfo]> in
        UserInfo.query(on: req.db).all()
    }

    // Post credenatails
    app.post("user") { req -> EventLoopFuture<HTTPStatus> in
        do {
            // Decode the recvied user credenails
            let receivedUserCredentials = try req.content.decode(UserInfo.self)

            return receivedUserCredentials.save(on: req.db).transform(to: .ok)

        } catch {
            throw Abort(.badRequest, reason: "Invalid credentails format\n")
        }
    }

    app.delete("user") { req -> EventLoopFuture<HTTPStatus> in
        guard let credentialIDString = req.query[String.self, at: "id"],
              let credentialID = UUID(uuidString: credentialIDString) else {
            throw Abort(.badRequest, reason: "Invalid format\n")
        }

        return UserInfo.query(on: req.db)
            .filter(\.$id == credentialID)
            .first()
            .flatMap { credential in
                if let credential = credential {
                    return credential.delete(on: req.db)
                        .transform(to: .noContent)
                } else {
                    return req.eventLoop.makeFailedFuture(
                        Abort(.notFound, reason: "ID \(credentialID) not found")
                    )
                }
            }
    }

    // find id by username
    app.get("user", "getUserId") { req -> EventLoopFuture<FindIDResponse> in
        guard let username = try? req.query.get(String.self, at: "username") else {
            throw Abort(.badRequest, reason: "Missing 'username' query parameter")
        }

        return UserInfo.query(on: req.db)
            .filter(\.$username == username)
            .first()
            .unwrap(or: Abort(.notFound, reason: "User not found"))
            .map { credentials in
                FindIDResponse(id: credentials.id)
            }
    }

    // get User by ID
    app.get("user", "getUserData") { req -> EventLoopFuture<UserInfo> in
        guard let userID = try? req.query.get(UUID.self, at: "id") else {
            throw Abort(.badRequest, reason: "Invalid Format for UDDID\n")
        }

        return UserInfo.query(on: req.db)
            .filter(\.$id == userID)
            .first()
            .unwrap(or: Abort(.notFound, reason: "UserID \(userID) not found"))
    }

    app.patch("user") { req -> EventLoopFuture<HTTPResponseStatus> in
        guard let credentialsID = req.query[UUID.self, at: "id"] else {
            throw Abort(.badRequest, reason: "Invalid Format\n")
        }

        let updatedCredentials = try req.content.decode(UpdateCredentials.self)

        return UserInfo.query(on: req.db)
            .filter(\.$id == credentialsID)
            .first()
            .flatMap { userCredentials in
                if let userCredentials = userCredentials {
                    userCredentials.password = updatedCredentials.password ?? "Test12!"

                    return userCredentials.update(on: req.db).transform(to: .noContent)
                } else {
                    return req.eventLoop.makeFailedFuture(
                        Abort(.notFound, reason: "Credentials with ID \(credentialsID) not found"))
                }
            }
    }
}
