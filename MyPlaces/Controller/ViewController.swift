//
//  ViewController.swift
//  MyPlaces
//
//  Created by Denis Medvedev on 18/06/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//отобразить кол-во строк необходимое для работы с таблицей
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
//метод позволяет поработать с самой ячейкой
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //создадим св-во с идентификатором переиспользуемой ячейки
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = "Cell"
        return cell!
    }
}

