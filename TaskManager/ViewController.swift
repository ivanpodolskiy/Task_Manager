//
//  ViewController.swift
//  TaskManager
//
//  Created by user on 17.04.2022.
//
import UIKit

class ViewController: UITableViewController {
    var mainTask: TaskCompositeProtocol = Task(name: "Главные задачи")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addNewTask(_ sendler: UIBarButtonItem) { showAlert() }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTask.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        guard let tasks = mainTask.showTask() as? [TaskCompositeProtocol] else {
            fatalError()
        }
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.detailTextLabel?.text = String(tasks[indexPath.row].count)
        cell.textLabel?.font = .systemFont(ofSize: 18)
        cell.detailTextLabel?.font = .systemFont(ofSize: 18)
        if tasks[indexPath.row].count != 0 {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tasks = mainTask.showTask() as? [TaskCompositeProtocol] else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        let task = tasks[indexPath.row]
        vc.mainTask = task
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .separator
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.textAlignment = .center
        label.text = mainTask.name
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        headerView.addSubview(label)
        return headerView
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Добавить новую задачу", message: "Напишите название", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "Добавить", style: .default) { action in
            guard let text = alertController.textFields?.first?.text else { return }
            if text != "" {
                self.mainTask.addTask(t: Task(name: text))
                self.tableView.reloadData()
            }
        }
        let cancelActionAlert = (UIAlertAction(title: "Отмена", style: .cancel))
        alertController.addAction(cancelActionAlert)
        alertController.addAction(actionAlert)
        alertController.addTextField { textField in
            textField.placeholder = "Название задачи"
        }
        present(alertController, animated: true)
    }
}

