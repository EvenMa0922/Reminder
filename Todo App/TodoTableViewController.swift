import UIKit


class TodoTableViewController: UITableViewController {
    var todoList = TaskModel()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoList.list!.count
        if let counter = todoList.list {
            return counter.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let task = todoList.list![indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell")!
//        cell.textLabel?.text = task
//        return cell
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "todoListCell")
        if let task = todoList.list {
            let mark = todoList.listForCheckmark
            if (mark![indexPath.row] == 1) {
                cell.textLabel?.text = task[indexPath.row] + " (Done)"
                cell.textLabel?.textColor = UIColor.gray
            } else {
                cell.textLabel?.text = task[indexPath.row]
                cell.textLabel?.textColor = UIColor.brown
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark) {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
//        }
        todoList.listForCheckmark![indexPath.row] *= -1
        todoList.saveDate()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.delete) {
//            todoList.list!.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
//            todoList.saveDate()
//            tableView.reloadData()
//        }
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]{

        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath) in
            let alert = UIAlertController(title: "Edit", message: "", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                textField.text = self.todoList.list![indexPath.row]
            })
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                self.todoList.list![indexPath.row] = alert.textFields!.first!.text!
                self.todoList.saveDate()
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        })

        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.todoList.list!.remove(at: indexPath.row)
            self.todoList.listForCheckmark!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            self.todoList.saveDate()
            tableView.reloadData()
        })

        return [deleteAction, editAction]
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        guard let EditVC = segue.destination as? EditViewController else {
//            return
//        }
//
//        EditVC.todoList = todoList.list!
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        todoList.listForCheckmark!.removeAll()
//        todoList.saveDate()
        todoList.loadData()
        tableView.reloadData()
//        print(todoList.listForCheckmark!)
    }
}
