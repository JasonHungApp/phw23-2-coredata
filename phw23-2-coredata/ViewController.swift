//
//  ViewController.swift
//  phw23-2-coredata
//
//  Created by jasonhung on 2024/5/31.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var stringLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateStringLabel()
    }

    func updateStringLabel() {
        if let values = fetchSimpleValues() {
            stringLabel.text = values.joined(separator: "\n")
        }
    }
    
    func insertSimpleValue(_ value: String) {
        let context = CoreDataStack.shared.context
        let entity = NSEntityDescription.entity(forEntityName: "SimpleEntity", in: context)!
        let simpleObject = NSManagedObject(entity: entity, insertInto: context)
        
        simpleObject.setValue(value, forKey: "simple_value")
        
        do {
            try context.save()
        } catch {
            print("Failed to save value: \(error)")
        }
    }
    
    func fetchSimpleValues() -> [String]? {
        let context = CoreDataStack.shared.context
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SimpleEntity")
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { $0.value(forKey: "simple_value") as? String }.compactMap { $0 }
        } catch {
            print("Failed to fetch values: \(error)")
            return nil
        }
    }

    func deleteAllData() {
        let context = CoreDataStack.shared.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SimpleEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save() // 保存上下文
        } catch {
            print("Failed to delete all data: \(error)")
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

