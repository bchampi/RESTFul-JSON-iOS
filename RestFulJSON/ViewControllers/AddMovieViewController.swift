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
            saveMovieButton.backgroundColor = UIColor.link
            editMovieButton.isEnabled = false
            editMovieButton.backgroundColor = UIColor.lightGray
        } else {
            saveMovieButton.isEnabled = false
            saveMovieButton.backgroundColor = UIColor.lightGray
            editMovieButton.isEnabled = true
            editMovieButton.backgroundColor = UIColor.link
            nameTextField.text = movie!.nombre
            genderTextField.text = movie!.genero
            durationTextField.text = movie!.duracion
        }
    }
    
    
    @IBAction func addMovieButtonAction(_ sender: Any) {
        
        methodHttp(link: link, httpMethod: "POST", data: loadData())
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editMovieButtonAction(_ sender: Any) {
        
        methodHttp(link: "\(link)\(movie!.id)", httpMethod: "PUT", data: loadData())
        navigationController?.popViewController(animated: true)
    }
    
    func loadData() -> Dictionary<String, Any> {
        let name = nameTextField.text!
        let gender = genderTextField.text!
        let duration = durationTextField.text!
        
        let data = ["usuarioId": 1, "nombre": name, "genero": gender, "duracion": duration] as Dictionary<String, Any>
        return data
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
