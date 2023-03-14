//
//  CustomCollectionViewCell.swift
//  Expense Manager
//
//  Created by Kamlesh on 2022-12-08.
//

import UIKit

class AddItemController: UIViewController{
    var itm : Expense!
    var forupdation = false

    

    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Description: UITextField!
    
    @IBOutlet weak var Amount: UITextField!
    
    @IBOutlet weak var inslbl: UILabel!
    @IBOutlet weak var errlbl: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    
    @IBOutlet weak var imageview: UIImageView!
    
    
    @IBAction func pickImage(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alertController = UIAlertController(title: nil, message: "Device has no camera.", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Close", style: .default, handler: { (alert: UIAlertAction!) in
            })

            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let picker = UIImagePickerController()
             picker.sourceType = .camera
             picker.delegate = self
             present(picker,animated: true)
        }
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if forupdation == true{
            setUpViews()
        }
    }
    
    private func setUpViews() {
        Name.text = itm.name
        Description.text = itm.desc
        Amount.text = String(itm.amount)
        if(itm.type == false){
            Switch.setOn(false, animated: false)
        }
        }
    
    private func createTable(){
        let database = SQLiteDatabase.sharedInstance
        database.createtable()
    }
    
    @IBAction func save(_ sender: Any) {
        let id: Int = forupdation == false ? 0 : itm.id
        if(Name.text?.isEmpty == true){
            errlbl.text = "Please Enter Expense Name"
            
        }else if( Description.text?.isEmpty == true){
            errlbl.text = "Please Enter Description"

        } else if( Amount.text?.isEmpty == true){
            errlbl.text = "Please Enter Amount"
        }else{
            
           let expenseValues = Expense(id: id, name: Name.text ?? "", desc: Description.text ?? "", amount: Double(Amount.text ?? "") ?? 0.0, type: Switch.isOn)
            if (forupdation == true){
                SQLiteCommands.updateRow(expenseValues)
            } else {
                CreateNewExpense(expenseValues)
            }
           SQLiteCommands.presentRows()
            clear()
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func clear(){
        errlbl.text = ""
        inslbl.text = ""
        Name.text = ""
        Description.text = ""
        Amount.text = ""
    }
    private func CreateNewExpense(_ expenseValues:Expense){
        let expenseAddedToTable = SQLiteCommands.insertRow(expenseValues)
        
        if expenseAddedToTable == true{
            dismiss(animated: true, completion: nil)
        }else{
            print("NOT ADDED KJL")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

extension AddItemController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            return
        }
        imageview.image = image
    }
}
