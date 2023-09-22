//
//  File.swift
//
//
//  Created by Basel Al Ali on 05.09.23.
//
import Fluent
import Vapor

final class UserInfo: Model, Content {
    // Name of the table
    static let schema = "user_credentials"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    @Field(key: "firstName")
    var firstName: String

    @Field(key: "lastName")
    var lastName: String

    @Field(key: "image")
    var image: String?

    init() {
    }

    init(id: UUID? = nil,
         username: String,
         password: String,
         firstName: String,
         lastName: String,
         image: String) {
        self.id = id
        self.username = username
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
    }
}
