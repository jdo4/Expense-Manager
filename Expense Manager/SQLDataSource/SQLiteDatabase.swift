//
//  CustomCollectionViewCell.swift
//  Expense Manager
//
//  Created by Kamlesh on 2022-12-08.
//
import Foundation
import SQLite

class SQLiteDatabase{
    static let sharedInstance = SQLiteDatabase()
    var database: Connection?
    
    private init(){
        do{
            let documentDirectory = try
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileurl = documentDirectory.appendingPathComponent("expenselist").appendingPathExtension("sqlite3")
            
            database = try Connection(fileurl.path)}
        catch{
            print("Creating connection to DB ERROR")
        }
    }
    
    func createtable(){
        SQLiteCommands.createTable()
    }
}
