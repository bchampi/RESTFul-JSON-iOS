//
//  ViewController.swift
//  RestFulJSON
//
//  Created by Mac 17 on 6/10/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var users = [Users]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func validarUsuario(ruta: String, completed: @escaping () -> ()){
        let url = URL(string: ruta)
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            if error == nil{
                do {
                    self.users = try JSONDecoder().decode([Users].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("Error en JSON")
                }
            }
        }.resume()
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        let ruta = "http://localhost:3000/usuarios?"
        let user = usernameTextField.text!
        let password = passwordTextField.text!
        let url = ruta + "nombre=\(user)&clave=\(password)"
        let createURL = url.replacingOccurrences(of: " ", with: "%20")
        validarUsuario(ruta: createURL){
            if self.users.count <= 0{
                print("Nombre de usuario y/o contraseña es incorrecto")
            }else{
                print("Logeo Exitoso")
                
                for data in self.users{
                    print("id:\(data.id), nombre:\(data.nombre), email:\(data.email)")
                }
               self.performSegue(withIdentifier: "segueLogin", sender: nil)
            }
        }
    }
    
}

