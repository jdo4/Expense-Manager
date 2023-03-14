//
//  CustomCollectionViewCell.swift
//  Expense Manager
//
//  Created by Kamlesh on 2022-12-08.
//

import UIKit

class ExpenseCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var type: UILabel!
    
    func setCellWithValuesOf(_ expense: Expense){
        name.text = expense.name
        desc.text = expense.desc
        amount.text = String(expense.amount)
        type.text = expense.type == true ? "Expense" : "Income"
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
}

