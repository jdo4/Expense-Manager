//
//  Dtlvwctrl.swift
//  Assignment_4
//
//  Created by JD on 2022-11-09.
//

import UIKit

class Dtlvwctrl : UIViewController , UITextFieldDelegate {
    
    var itm : Itm!
    

    @IBOutlet weak var miletxtfld: UITextField!
    @IBOutlet weak var sourcetxtfld: UITextField!
    @IBOutlet weak var destinationtxtfld: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.endEditing(true)
        sourcetxtfld.text = itm.f1
        destinationtxtfld.text = itm.f2
        miletxtfld.text = itm.f3
    }
    
    @IBOutlet weak var errlbl: UILabel!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.endEditing(true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
//    @IBAction func savebtn(_ sender: Any) {
//        if(sourcetxtfld.text == ""){
//            errlbl.text = "Please Enter Source"
//        }else{
//            if(destinationtxtfld.text == ""){
//                errlbl.text = "Please Enter Destination"
//                
//            }else{
//                if(miletxtfld.text == ""){
//                    errlbl.text = "Please Enter Milage"
//
//                }else if(!isValidNumber(string: miletxtfld.text ?? "")){
//                    errlbl.text = "Please Enter Valid Milage"
//                }else{
//                    itm.f1 = sourcetxtfld.text ?? ""
//                    itm.f2 = destinationtxtfld.text ?? ""
//                    itm.f3 = miletxtfld.text ?? ""
//                    self.navigationController?.popViewController(animated: true)
//                    self.dismiss(animated: true, completion: nil)
//
//                }
//            }
//        }
//    }
}


