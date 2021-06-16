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
    var ruta = "http://localhost:3000/peliculas"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMovies(ruta: ruta) {
            self.tableView.reloadData()
        }
    }

    
    @IBAction func searchMovieButtonAction(_ sender: Any) {
        let name = searchMovieTextField.text!
        let url = ruta + "?nombre_like=\(name)"
        let createURL = url.replacingOccurrences(of: " ", with: "%20")
        
        if name.isEmpty {
            loadMovies(ruta: ruta) {
                self.tableView.reloadData()
            }
        } else {
            loadMovies(ruta: createURL) {
                if self.movies.count <= 0 {
                    self.showAlert(_title: "Error", "No se encontraron coincidencias para : \(name)", action: "Cancel")
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func loadMovies(ruta: String, completed: @escaping () -> ()){
        let url = URL(string: ruta)
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
    
    func showAlert(_title: String, _ message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: action, style: .default, handler:nil))
        present(alert, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count != 0 ? movies.count : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMovies", for: indexPath)

        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.nombre
        cell.detailTextLabel?.text = "Genero: \(movie.genero), Duración: \(movie.duracion)"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
