//
//  Movies.swift
//  RestFulJSON
//
//  Created by Mac 17 on 6/16/21.
//  Copyright © 2021 deah. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    let usuarioId: Int
    let id: Int
    let nombre: String
    let genero: String
    let duracion: String
}
