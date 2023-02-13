//
//  ViewController4.swift
//  Vize-Final
//
//  Created by Bircan Sezgin on 13.02.2023.
//

import UIKit
import CoreData

class ViewController4: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dersArray = [Float]()
    var idArray = [UUID]()
    

    @IBOutlet weak var tableView1: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView1.delegate = self
        tableView1.dataSource = self
        
        // Data Çağırdık
        getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = ""
        return cell
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
                
                if let id = results.value(forKey: "id") as? UUID{
                    self.idArray.append(id )
                }
                
                self.tableView1.reloadData()
                
            }
            
            
        }catch{
            
        }
    }

}
