//
//  itmstr.swift
//  Assignment_4
//
//  Created by user215134 on 11/7/22.
// THIS FILE IS USED TO STORE DATA OF APPLICATION LIKE SHARED PREFERENCES	

import UIKit

class Itmstr{
    var itmarr : [Itm] = []
    
    let itmarchurl: URL = {
        let dds = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dd = dds.first!
        return dd.appendingPathComponent("items.archive")
    }()
    
    init(){
        do{
            if let data = UserDefaults.standard.data(forKey: "SavedItems"){
                let arcitms = try NSKeyedUnarchiver.unarchivedObject(ofClasses:
                                                                    [NSArray.self, Itm.self], from: data) as? [Itm]
                self.itmarr = arcitms!
               
            } else{
                print("no data")
            }
            
        }catch {
            print("some err")
        }
    }
    
    func svchnges() -> Bool{
        var res : Bool = true
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: itmarr, requiringSecureCoding: true)
            try data.write(to: itmarchurl)
            UserDefaults.standard.set(data, forKey: "SavedItems")
        }catch{
            res = false
            
        }
        return res
    }
}
