//
//  BankCollectionViewCell.swift
//  Assignment_4
//
//  Created by JD on 2022-12-08.
//

import UIKit

class UserCollectionCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNumber: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderColor = UIColor.gray.cgColor
        containerView.layer.borderWidth = 0.5

    }

}
