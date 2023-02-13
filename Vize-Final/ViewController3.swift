//
//  ViewController3.swift
//  Vize-Final
//
//  Created by Bircan Sezgin on 12.02.2023.
//

import UIKit

class ViewController3: UIViewController {
    
    var sonuc1: Float = 0.0
    @IBOutlet weak var sonucLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sonucLabel.text = "\(sonuc1)"
 
        
       /* if let sonuc = sonuc1{
            if sonuc >= 50.00{
                uyarı(titleMassage: "Geçtiniz", message: "Helal lan")
                sonucLabel.text = "Soncunuz : \(sonuc)"
            }
            else{
                uyarı(titleMassage: "Harbi Kofti", message: "Hadi yol")
                sonucLabel.text = "Soncunuz : \(sonuc)"
            }
        }*/
        
    }
    
    func uyarı(titleMassage:String, message:String){
        let alert = UIAlertController(title: titleMassage, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }



}
