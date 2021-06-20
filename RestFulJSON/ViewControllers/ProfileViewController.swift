//
//  ProfileViewController.swift
//  RestFulJSON
//
//  Created by Mac 17 on 6/19/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let link = "http://localhost:3000/usuarios/"
    
    let id = UserDefaults.standard.string(forKey: "id")!
    let username = UserDefaults.standard.string(forKey: "username")!
    let email = UserDefaults.standard.string(forKey: "email")!
    let password = UserDefaults.standard.string(forKey: "password")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = username
        emailTextField.text = email
        passwordTextField.text = password
    }
    
    
    @IBAction func saveProfileButtonAction(_ sender: Any) {
        
        methodHttp(link: link + id, httpMethod: "PUT", data: loadData())
        let alert = UIAlertController(title: "Alerta", message: "Perfil actualizado correctamente", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: { (action) in
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadData() -> Dictionary<String, Any> {
        let username = usernameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let data = ["id": id, "nombre": username, "email": email, "clave": password] as Dictionary<String, Any>
        return data
    }
    
}
