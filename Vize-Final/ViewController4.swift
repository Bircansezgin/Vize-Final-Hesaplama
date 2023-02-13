//
//  ViewController4.swift
//  Vize-Final
//
//  Created by Bircan Sezgin on 13.02.2023.
//

import UIKit
import CoreData





class ViewController4: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var veriLabel: UILabel!
    var dersArray = [Float](){
        // her değişimde kendini ayarla
        didSet{
            dersArray = dersArray.reversed()
        }
    }
    
    var dersAdi = [String](){
        // her değişimde kendini ayarla
        didSet{
            dersAdi = dersAdi.reversed()
        }
    }
    
    var idArray = [UUID]()
    
    
    

    @IBOutlet weak var tableView1: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView1.delegate = self
        tableView1.dataSource = self
        
        
        // Data Çağırdık
        getData()
        
        
    }
    
    
    @IBAction func geriButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dersAdi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let not = dersArray[indexPath.row]
        let dersAdi = dersAdi[indexPath.row]
        cell.textLabel?.text = "Ders adı : \(dersAdi) = \(not)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: UIContextualAction.Style.destructive, title: "Sil") { _,_,_ in
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }


    var dataSay = 0
    
    //Data çekmek.
    @objc func getData(){
        
        // ikiz Verileri Temizlemek.
        self.dersArray.removeAll(keepingCapacity: true)
        
        dataSay += 1
        guard let appdelegete = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appdelegete.persistentContainer.viewContext
        let fetchRequ = NSFetchRequest<NSFetchRequestResult>(entityName: "Notlar")
        
        fetchRequ.returnsObjectsAsFaults = false
        
        do {
            let res = try context.fetch(fetchRequ)
            for results in res as! [NSManagedObject]{
                if let not = results.value(forKey: "not") as? Float{
                    self.dersArray.append(not)
                }
                
                if let dersadi = results.value(forKey: "ders") as? String{
                    self.dersAdi.append(dersadi)
                    
                }
                
                if let id = results.value(forKey: "id") as? UUID{
                    self.idArray.append(id )
                }
                
                self.tableView1.reloadData()
                
            }
            
            
        }catch{
            
        }
    }

}
