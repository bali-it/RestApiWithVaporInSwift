//
//  File.swift
//
//
//  Created by Basel Al Ali on 05.09.23.
//

import Vapor

struct FindIDResponse: Content {
    let id: UserInfo.IDValue?
}
