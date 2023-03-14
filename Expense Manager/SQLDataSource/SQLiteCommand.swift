//
//  CustomCollectionViewCell.swift
//  Expense Manager
//
//  Created by Kamlesh on 2022-12-08.
//

import Foundation
import SQLite

class SQLiteCommands {
    
    static var table = Table("expense")
    
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let desc = Expression<String>("desc")
    static let amount = Expression<Double>("amount")
    static let type = Expression<Bool>("type")
    
    static func createTable(){
        guard let database =
                SQLiteDatabase.sharedInstance.database else{
            print("ERROR")
            return
        }
        do{
            try database.run(table.create(ifNotExists: true) {
                table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(desc)
                table.column(amount)
                table.column(type)
            })
        }catch{
            print("Table Already Exists")
        }
    }
    
    static func insertRow(_ expenseValues:Expense) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else{
            print("DB Connection Error")
            return nil
        }
        do{
            try database.run(table.insert(name <- expenseValues.name,
                                          desc <- expenseValues.desc,
                                          amount <- expenseValues.amount,
                                          type <- expenseValues.type))
            return true
        }catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT{
            print("FAILED INSERTION \(message), in \(String(describing: statement))")
            return false
        }catch let error{
            print("INSERTION FAILED ERROR")
            return false
        }
    }
    
    
    static func updateRow(_ expenseValue: Expense) -> Bool?{
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        let expense = table.filter(id == expenseValue.id).limit(1)
        do{
            if try database.run(expense.update(name <- expenseValue.name,
                                               desc <- expenseValue.desc,
                                               amount <- expenseValue.amount,
                                               type <- expenseValue.type)) > 0{
                print("Expense Updated")
                return true
            } else {
                print("NOT FOUND")
            }
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Update row failed: \(message)")
            return false
        } catch let error{
            print("FAILED:")
            return false
        }
        return true
    }
    
    static func deleteRow(expenseId: Int){
        print("ExpenseId is \(expenseId)")
        guard let database = SQLiteDatabase.sharedInstance.database
        else{
            print("Datastore connection error")
            return
        }
        do{
            let expense = table.filter(id == expenseId).limit(1)
            try database.run(expense.delete())
        }catch{
            print("Delete Row Error: \(error)")
        }
    }
    static func presentRows() -> [Expense]? {
        guard let database = SQLiteDatabase.sharedInstance.database else{
            print("Datastore connction error")
            return nil
        }
        
        
        var expenseArray = [Expense]()
        
        table = table.order(id.desc)
        
        do {
            for expense in try database.prepare(table){
                
                let idValue = expense[id]
                let name = expense[name]
                let desc = expense[desc]
                let amount = expense[amount]
                let type = expense[type]
                
                let expenseObject = Expense(id: idValue, name: name, desc: desc, amount: amount, type: type)
                expenseArray.append(expenseObject)
            }
        } catch {
            print("Present Row Error: \(error)")
        }
        return expenseArray
        
    }
}

struct Expense{
    let id: Int
    let name: String
    let desc: String
    let amount: Double
    let type: Bool
}
