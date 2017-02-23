//
//  ViewController.swift
//  Pocket_Museum
//
//  Created by Emmanuel Desprez on 22/02/2017.
//  Copyright © 2017 Emmanuel Desprez. All rights reserved.
//

import UIKit
import Alamofire

class MuseumListViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var myTableView: UITableView!
    
    
    // MARK: - Variables
    var museumList = [Museum]()
    
    
    // MARK: - Cycle de vie app
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        fetchMuseum()
        
    }
    
    
    
    // MARK: - Function
    func fetchMuseum() {
        
        Alamofire.request(Parameters.API_Url).validate().responseJSON { (response:DataResponse<Any>) in
            if response.result.isSuccess {
                if let museumDict = response.result.value as? [String: Any] {
                    if let records = museumDict["records"] as? [[String: Any]]{
                        for museum in records {
                            if let fields = museum["fields"]as? [String: Any] {
                                if let museumName = fields["nom_du_musee"] as? String,
                                    let museumSchedules = fields["periode_ouverture"] as? String{
                                    self.museumList.append(Museum(museumName: museumName, museumSchedules: museumSchedules))
                                }
                                
                            }
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        }
                        
                    }
                    
                }
                
            }
            
        }
    }
 
    
    
    
    
}





// MARK: - Extension- TableView
extension MuseumListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // A modifier, retourner le nombre de ligne dans la section
        return museumList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "museumCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MuseumCell
        
        let museum = museumList[indexPath.row]
        cell.display(museum: museum)
        
        return cell
    }
    
    //    // MARK: - Couleur de fond tableView
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
    //                   forRowAt indexPath: IndexPath) {
    //        cell.backgroundColor = UIColor.clear
    //    }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            stationSelected = indexPath.row       // Attention au sens d'initialisation : ça en 1er
            self.performSegue(withIdentifier: "MapView", sender: self)  // ça en 2eme
            tableView.deselectRow(at: indexPath, animated: false)
        }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let cell = sender as? UITableViewCell {
                if let indexPath = self.tableView.indexPath(for: cell) {
                    let selectedPerson = _personList[indexPath.row]
                    
                    let personViewController:PersonViewController = segue.destination as! PersonViewController
                    personViewController._person = selectedPerson
                }
                
            }
        }
    }

    
}

