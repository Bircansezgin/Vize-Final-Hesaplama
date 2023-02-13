//
//  ViewController2.swift
//  Vize-Final
//
//  Created by Bircan Sezgin on 12.02.2023.
//

import UIKit
import CoreData

class ViewController2: UIViewController {
    
    
    @IBOutlet weak var vizeNot: UITextField!
    @IBOutlet weak var finalNot: UITextField!
    @IBOutlet weak var labNot: UITextField!
    @IBOutlet weak var extraNot: UITextField!
    
    @IBOutlet weak var vizeYuzde: UITextField!
    @IBOutlet weak var finalYuzde: UITextField!
    @IBOutlet weak var labYuzde: UITextField!
    @IBOutlet weak var extraYuzde: UITextField!
    
    @IBOutlet weak var sonNot: UILabel!
    
    
    var toplam = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        uyarı(titleMassage: "Uyarı", message: "Yüzdelikleri 0.0 olarak yazınız. Örneğin, %10 = 0.10")
        
        //klavye kapatmak.
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyborad))
        view.addGestureRecognizer(gestureRecognizer)
        
        
        
        
        
    }
    
    @IBAction func hesapla(_ sender: Any) {
        // Hesaplama
        if let vize = vizeNot.text, let final = finalNot.text, let lab = labNot.text, let extra = extraNot.text, let vizeY = vizeYuzde.text, let finalY = finalYuzde.text, let labY = labYuzde.text, let extraY = extraYuzde.text{
            
            let vizeToplam = (Float(vize) ?? 0) * (Float(vizeY) ?? 0)
            let FinalToplam = (Float(final) ?? 0) * (Float(finalY) ?? 0)
            let labToplam = (Float(lab) ?? 0) * (Float(labY) ?? 0)
            let extraToplam = (Float(extra) ?? 0) * (Float(extraY) ?? 0)
            
            let total = vizeToplam + FinalToplam + labToplam + extraToplam
            
            if total >= 50.00{
                sonuc(titleMassage: "Tebrikler", message: "Geçtiniz : \(total)")
            }else{
                sonuc(titleMassage: "Üzgünüz", message: "Kaldınız : \(total)")
            }
// -----------------------// -----------------------// -----------------------//
            // Veri kaydetme.
            let appdelegete = UIApplication.shared.delegate as! AppDelegate
            let context = appdelegete.persistentContainer.viewContext
            let saveData = NSEntityDescription.insertNewObject(forEntityName: "Notlar", into: context )
            
            saveData.setValue(total , forKey: "not")
            saveData.setValue(UUID(), forKey: "id")
            
            do {
                try context.save()
                print("OKEY")
            }catch{
                print("error")
            }
// -----------------------// -----------------------// -----------------------//
            // Bir önceki Sayfaya Geçmek için gönderilen haberci.
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "newData"), object: "nil")
            
            
            
            //performSegue(withIdentifier: "go3", sender: total)
        
            
        }
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goTable"{
            if let gelenVeriHesap = sender as? Float{
                let erisim = segue.destination as! ViewController4
                
            }
        }
    }
    
    

    
    
    func uyarı(titleMassage:String, message:String){
        let alert = UIAlertController(title: titleMassage, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func sonuc(titleMassage:String, message:String){
        let alert = UIAlertController(title: titleMassage, message: message, preferredStyle: UIAlertController.Style.alert)
        // Ok butonunda basına kapatılsın.
        let ok = UIAlertAction(title: "Yeniden Hesapla", style: UIAlertAction.Style.cancel)
        let kapat = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.destructive) { UIAlertAction in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        alert.addAction(kapat)
        self.present(alert, animated: true, completion: nil)
    }

    @objc func hideKeyborad(){
        view.endEditing(true)
    }
}
