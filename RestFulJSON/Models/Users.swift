//
//  Users.swift
//  RestFulJSON
//
//  Created by Mac 17 on 6/16/21.
//  Copyright © 2021 deah. All rights reserved.
//

import Foundation

struct Users: Decodable {
    let id: Int
    let nombre: String
    let clave: String
    let email: String
}
