//
//  BankController.swift
//  Assignment_4
//
//  Created by JD on 2022-12-08.
//

import Foundation
import UIKit


class BankController: UIViewController {
    var banklist = [BankModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.npoint.io/196de63dbc6a37560778/data/")
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            if error == nil{
                do{
                    self.banklist = try JSONDecoder().decode([BankModel].self, from: data!)
                    print(data?.count)
                }catch{
                    print("SOME ERROR WHILE PARSING")
                }
                DispatchQueue.main.async {
                    print(self.banklist.count)
                }
            }
        }.resume()
        
    }
}


struct BankModel: Decodable{
    let id: String?
    let name: String?
    let image: String?
    let country: String?
}
