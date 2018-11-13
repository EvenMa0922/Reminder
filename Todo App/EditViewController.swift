import UIKit

class EditViewController: UIViewController {
    var todoList = TaskModel()
    
    @IBOutlet weak var task: UITextField!
    
    // When press the submit button, if the task is exsiting(the string from textfield is not empty)
    // it will be appended to todoList.list, and also a -1(means this new task is undo) will be
    // appended to todoList.listForStatus
    @IBAction func submit(_ sender: UIButton) {
        if let newTask = task.text {
            if(newTask != "") {
                todoList.list!.append(newTask)
                todoList.listForCheckmark?.append(-1)
                todoList.saveDate()
                task.text = ""
            }
        }
//        performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
//        performSegue(withIdentifier: "update", sender: self)
    }
    
    // Press this button will reset textfield to empty
    @IBAction func cancle(_ sender: UIButton) {
        if (task.text != "") {
            task.text = ""
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard let todoTVC = segue.destination as? TodoTableViewController else {
//            return
//        }
//        todoTVC.todoList.list = todoList
//    }
}
