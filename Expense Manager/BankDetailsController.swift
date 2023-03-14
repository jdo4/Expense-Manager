//
//  CustomCollectionViewCell.swift
//  Expense Manager
//
//  Created by Kamlesh on 2022-12-08.
//

import Foundation
import UIKit


class BankDetailsController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    var banklist = [BankModel]()
    
    @IBOutlet weak var mycollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mycollectionview.dataSource = self
        mycollectionview.delegate = self
        
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
                    self.mycollectionview.reloadData()
                }
            }
        }.resume()
    }
    
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banklist.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mycollectionview.dequeueReusableCell(withReuseIdentifier: "BankCollectionCell", for: indexPath) as! CustomCollectionViewCell
        var path = banklist[indexPath.row]
        cell.name.text = path.name
        let url = URL(string: path.image ?? "")
        let data = try? Data(contentsOf: url!)
        cell.logo.image = UIImage(data: data!)
        cell.country.text = path.country
        
        return cell
    }
   
}
struct BankModel: Decodable{
    let id: String?
    let name: String?
    let image: String?
    let country: String?
}

