//
//  itm.swift
//  Assignment_4
//
//  Created by user215134 on 11/7/22.
//

import Foundation

class Itm : NSObject, NSSecureCoding{
    
    
    static var supportsSecureCoding: Bool{
        get {
            return true
        }
    }
    var f1 : String
    var f2 : String
    var f3 : String
    
    override init(){
        f1 = ""
        f2 = ""
        f3 = ""
        super.init()
    }
    func encode(with coder: NSCoder) {
        coder.encode(f1, forKey: "f1")
        coder.encode(f2, forKey: "f2")
        coder.encode(f3, forKey: "f3")
    }
    
    required init?(coder: NSCoder) {
        f1 = coder.decodeObject(forKey: "f1") as! String
        f2 = coder.decodeObject(forKey: "f2") as! String
        f3 = coder.decodeObject(forKey: "f3") as! String
        super.init()
    }
    
}
