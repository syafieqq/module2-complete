//
//  ViewController.swift
//  Country List
//
//  Created by megat on 23/03/2019.
//  Copyright © 2019 Megat Syafiq. All rights reserved.
//

import UIKit
import Alamofire

struct CountyList {
    var countryName: String
}

class ViewController: UIViewController {

    var details = [CountyList]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryList()
    }
    
    func getCountryList () {
        let url = "http://api.jsonbin.io/b/5b927045ab9a186eafe6de1f"
        Alamofire.request(url).validate(statusCode: 200..<300).responseJSON { response in
            if (response.result.isSuccess){
                if let data = response.result.value as? NSArray {
                    for element in data {
                        if let data2 = element as? NSDictionary {
                            if let countryname = data2["name"] as? String {
                                let country = CountyList(countryName: countryname)
                                self.details.append(country)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let country: CountyList
        country = details[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countrycell") as? CountryCell
        
        cell!.countryName.text = country.countryName
        
        return cell!
    }
    
    
}

