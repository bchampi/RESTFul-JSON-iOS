//
//  SearchMovieViewController.swift
//  RestFulJSON
//
//  Created by Mac 17 on 6/16/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit

class SearchMovieViewController: UITableViewController {
    
    
    @IBOutlet weak var searchMovieTextField: UITextField!
    
    var movies = [Movies]()
    var link = "http://localhost:3000/peliculas"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMovies(link: link) {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadMovies(link: link) {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchMovieButtonAction(_ sender: Any) {
        let name = searchMovieTextField.text!
        let url = link + "?nombre_like=\(name)"
        let createURL = url.replacingOccurrences(of: " ", with: "%20")
        
        if name.isEmpty {
            loadMovies(link: link) {
                self.tableView.reloadData()
            }
        } else {
            loadMovies(link: createURL) {
                if self.movies.count <= 0 {
                    self.showAlertError(_title: "Error", "No se encontraron coincidencias para : \(name)", action: "Cancel")
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func loadMovies(link: String, completed: @escaping () -> ()){
        let url = URL(string: link)
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            if error == nil{
                do {
                    self.movies = try JSONDecoder().decode([Movies].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("Error en JSON")
                }
            }
        }.resume()
    }
    
    func showAlertError(_title: String, _ message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: action, style: .default, handler:nil))
        present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count != 0 ? movies.count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        let movie = movies[indexPath.row]
        
        cell.nameMovieLabel.text = movie.nombre
        cell.genderMovieLabel.text = movie.genero
        cell.durationMovieLabel.text = "\(movie.duracion) min"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.performSegue(withIdentifier: "segueEditMovie", sender: movie)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        
        if editingStyle == .delete {
            showAlert("Borrar Registro", "¿Estás seguro de eliminar la película \(movie.nombre)?", movie.id)
        }
    }
    
    func showAlert(_ title: String, _ message: String, _ movieId: Int) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Eliminar", style: .destructive, handler: { (action) in
            let data = ["": ""] as Dictionary<String, Any>
            methodHttp(link: "\(self.link)/\(movieId)", httpMethod: "DELETE", data: data)
            self.loadMovies(link: self.link) {
                self.tableView.reloadData()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEditMovie" {
            let nextVC = segue.destination as! AddMovieViewController
            nextVC.movie = sender as? Movies
        }
    }

}
