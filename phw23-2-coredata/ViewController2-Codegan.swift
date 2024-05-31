//
//  ViewController2-Codegan.swift
//  phw23-2-coredata
//
//  Created by jasonhung on 2024/5/31.
//

import UIKit
import CoreData

class ViewController2_Codegan: UIViewController {
    
    @IBOutlet weak var stringLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertSimpleValue("Jason:\(Int.random(in: 0..<100))")
        updateStringLabel()
    }
    
    func insertSimpleValue(_ value: String) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let simpleEntity = SimpleEntity(context: context)
        simpleEntity.simple_value = value
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchSimpleValues() -> [String]? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = SimpleEntity.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { $0.simple_value ?? "" }
        } catch {
            print("Failed to fetch values: \(error)")
            return nil
        }
    }
    
    func deleteAllData() {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SimpleEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save() // 保存上下文
        } catch {
            print("Failed to delete all data: \(error)")
        }
    }
    
    func updateStringLabel() {
        if let values = fetchSimpleValues() {
            stringLabel.text = values.joined(separator: "\n")
        }
    }
    
    @IBAction func AddString(_ sender: Any) {
        insertSimpleValue("Jason:\(Int.random(in: 0..<100))")
        updateStringLabel()

    }
    
    @IBAction func deleteAll(_ sender: Any) {
        deleteAllData()
        updateStringLabel()
    }
}
