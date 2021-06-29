//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Denis Medvedev on 25/06/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {


    var places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    //медоб возвращает количество секций, на которые поделены все ячейки
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //метод возвращает кол-во ячеек в одной секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

//    метод возвращает
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let place = places[indexPath.row]

        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        
        if place.image == nil {
            cell.imageOfPlace.image = UIImage(named: place.restaurantImage!)
        } else {
            cell.imageOfPlace.image = place.image
        }
        
        
        
        cell.imageOfPlace .layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        //обрезать само изображение по обрезке imageview
        cell.imageOfPlace.clipsToBounds = true

        return cell
    }
    
    // MARK - Table view delegate
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 85
//    }
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToMainVC(_ segue: UIStoryboardSegue) {
        guard let svc = segue.source as? NewPlaceViewController else { return }
        // вызов данного метода произойдет быстрее чем мы закроем VC, таким образом мы успеем сохранить внесенные в поля значения
        svc.saveNewPlace()
        places.append(svc.newPlace!)
        //обновим интерфейс
        tableView.reloadData()
    }

}
