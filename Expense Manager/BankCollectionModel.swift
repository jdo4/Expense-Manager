//
//  BankCollectionModel.swift
//  Assignment_4
//
//  Created by JD on 2022-12-08.
//


import Foundation
import UIKit

struct BankInfoModel {
    var id: String?
    var name: String?
    var image: UIImage?
    var country: String?
}


class BModel : Equatable {
    static func == (lhs: BModel, rhs: BModel) -> Bool {
        return true
    }
    
    var id: String
    var name: String
    var imgURL: String
    var country: String
    
    init(id: String, name: String,country: String, imgURL: String) {
        self.id = id
        self.name = name
        self.imgURL = imgURL
        self.country = country
    }
}
