//
//  methodHttp.swift
//  RestFulJSON
//
//  Created by Mac 17 on 6/19/21.
//  Copyright © 2021 deah. All rights reserved.
//

import Foundation

func methodHttp(link: String, httpMethod: String, data: [String: Any]) {
    let url: URL = URL(string: link)!
    var request = URLRequest(url: url)
    let session = URLSession.shared
    request.httpMethod = httpMethod
    let params = data
    
    if httpMethod != "DELETE" {
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print("Se produjo un error en el metodo \(httpMethod)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
        if (data != nil) {
            do {
                let _ = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
            } catch {
                print("Error en la data")
            }
        }
    })
    task.resume()
}
