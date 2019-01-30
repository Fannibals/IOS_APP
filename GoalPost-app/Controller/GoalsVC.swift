//
//  GoalsVC.swift
//  GoalPost-app
//
//  Created by Ethan  on 29/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCoreDataObject()
        
    }
    
    func fetchCoreDataObject() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1{
                    tableView.isHidden = false
                    tableView.reloadData()
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }


    @IBAction func addGoalBtnPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {return}
        presentDetail(createGoalVC)
    }
    
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal:goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(indexPath: indexPath)
            self.fetchCoreDataObject()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        
        let addAction = UITableViewRowAction(style: .normal, title: "add 1") { (rowAction, indexPath) in
            self.setProgress(indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = UIColor.red
        addAction.backgroundColor = UIColor.orange
        return [deleteAction, addAction]
    }
}

extension GoalsVC {
    
    func setProgress(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompleteValue {
            chosenGoal.goalProgress += 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Successfully set progress")
        } catch {
            debugPrint(error)
        }
        
    }
    
    func removeGoal(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed data")
        } catch {
            debugPrint(error)
        }
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Goal")
        
        do {
            goals = try managedContext.fetch(fetchRequest) as! [Goal]
            print("Successfully fetched data")
            completion(true)
        } catch {
            debugPrint(error)
            completion(false)
        }
    }
}

