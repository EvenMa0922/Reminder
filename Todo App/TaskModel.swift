import UIKit

class TaskModel{
    var list: [String]?     // The array used to save tasks
    var listForCheckmark: [Int]?        // The array used to save task's conditions(done or not)
    
    let userDefault = UserDefaults.standard
    
    init() {
        if let test = userDefault.array(forKey: "list") as? [String] {
            list = test
        } else {
            list = []
        }
        
        // Use integer array to mark task's condition. If it's 1 it's done, else it's not.
        if let test2 = userDefault.array(forKey: "listForCheckmark") as? [Int] {
            listForCheckmark = test2
        } else {
            listForCheckmark = []
        }
    }
    
    func saveDate(){
        userDefault.set(list, forKey: "list")
        userDefault.set(listForCheckmark, forKey: "listForCheckmark")
    }
    
    func loadData(){
        list = (userDefault.array(forKey: "list") as? [String])
        listForCheckmark = (userDefault.array(forKey: "listForCheckmark") as? [Int])
    }
    
}
