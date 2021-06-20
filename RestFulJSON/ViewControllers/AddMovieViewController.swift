//
//  AddMovieViewController.swift
//  RestFulJSON
//
//  Created by Mac 17 on 6/19/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit

class AddMovieViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBOutlet weak var saveMovieButton: UIButton!
    @IBOutlet weak var editMovieButton: UIButton!
    
    var movie: Movies?
    let link = "http://localhost:3000/peliculas/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if movie == nil {
            saveMovieButton.isEnabled = true
            editMovieButton.isEnabled = false
        } else {
            saveMovieButton.isEnabled = false
            editMovieButton.isEnabled = true
            nameTextField.text = movie!.nombre
            genderTextField.text = movie!.genero
            durationTextField.text = movie!.duracion
        }
    }
    
    
    @IBAction func addMovieButtonAction(_ sender: Any) {
        
        methodHTTP(link: link, httpMethod: "POST", data: loadData())
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editMovieButtonAction(_ sender: Any) {
        
        methodHTTP(link: "\(link)\(movie!.id)", httpMethod: "PUT", data: loadData())
        navigationController?.popViewController(animated: true)
    }
    
    func loadData() -> Dictionary<String, Any> {
        let name = nameTextField.text!
        let gender = genderTextField.text!
        let duration = durationTextField.text!
        
        let data = ["usuarioId": 1, "nombre": name, "genero": gender, "duracion": duration] as Dictionary<String, Any>
        return data
    }
    
    func methodHTTP(link: String, httpMethod: String, data: [String: Any]) {
        let url: URL = URL(string: link)!
        var request = URLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = httpMethod
        let params = data
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print("Se produjo un error en el metodo \(httpMethod)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
