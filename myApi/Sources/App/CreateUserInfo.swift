//
//  File.swift
//
//
//  Created by Basel Al Ali on 05.09.23.
//

import Fluent


struct CreateUserInfo: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UserInfo.schema)
            .field("id", .uuid, .identifier(auto: false))
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("firstName", .string, .required)
            .field("lastName", .string, .required)
            .field("image", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UserInfo.schema)
            .delete()
    }
}
