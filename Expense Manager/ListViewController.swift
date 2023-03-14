//
//  CustomCollectionViewCell.swift
//  Expense Manager
//
//  Created by Kamlesh on 2022-12-08.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate , UITableViewDataSource
{
    @IBOutlet weak var incomelabel: UILabel!
    @IBOutlet weak var explabel: UILabel!
    
    
    func loadDataFromSQLiteDatabase(){
           expenseArray = SQLiteCommands.presentRows() ?? []
        loadtotals()
    }
    
    private var expenseArray = [Expense]()
    @IBOutlet weak var mytblvw: UITableView!
    required init?(coder Decoder: NSCoder) {
        super.init(coder: Decoder)
    }
    @IBOutlet weak var Ttltrip: UILabel!
    @IBAction func refresh(_ sender: Any) {
        mytblvw.reloadData()
    }
    
    
    @IBAction func floatbutton(_ sender: Any) {

    }
    func connectToDatabase(){
           _ = SQLiteDatabase.sharedInstance
    }
    func loadtotals(){
        var incmttt = 0;
        var expttt = 0;
        for incmttl in expenseArray {
            if(incmttl.type == true){
                incmttt = incmttt + (Int(incmttl.amount) ?? 0)
            }
            if(incmttl.type == false){
                expttt = expttt + (Int(incmttl.amount) ?? 0)
            }
        }
        incomelabel.text = String(incmttt)
        explabel.text = String(expttt)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        incomelabel.text = "0.0"
        explabel.text = "0.0"
        connectToDatabase()
        loadDataFromSQLiteDatabase()
        self.mytblvw.rowHeight = 80;
        mytblvw.delegate = self
        mytblvw.dataSource = self
    }



    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDataFromSQLiteDatabase()
        mytblvw.reloadData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expenseArray.count != 0){
            return expenseArray.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ExpenseCell
        let itm = expenseArray[indexPath.row]
        cell?.name.text = itm.name
        cell?.desc.text = itm.desc
        cell?.amount.text = String(itm.amount)
        cell?.type.text = String(itm.type) == "false" ? "Expense" : "Income"
        if String(itm.type) == "true" { cell?.backgroundColor = UIColor.green } else{ cell?.backgroundColor = UIColor.red}
        if String(itm.type) == "true" {
            cell?.img.image = UIImage(systemName: "chart.line.uptrend.xyaxis") }
        else{ cell?.img.image = UIImage(systemName: "chart.line.downtrend.xyaxis")}
        return cell ?? cell!
    }

    
    
    

    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) {_ in
                let delete = UIAction(title: "Delete"){ [self]_ in
                    SQLiteCommands.deleteRow(expenseId: expenseArray[indexPath.row].id)
                    self.loadDataFromSQLiteDatabase()
                    self.mytblvw.reloadData()
                }
                
                return UIMenu(title: "Menu", children:[delete])



            }
}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editexpense"{
            if let row = mytblvw.indexPathForSelectedRow?.row{
                let itm = expenseArray[row]
                let additmcntrl = segue.destination as! AddItemController
                additmcntrl.itm = itm
                additmcntrl.forupdation = true
            }
            }
        if segue.identifier == "charts"{
            let piechart = segue.destination as! ReportsController
            piechart.income = Double(incomelabel.text!) ?? 0.0
            piechart.expence = Double(explabel.text!) ?? 0.0
            }
        }
    

}
