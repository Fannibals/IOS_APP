//
//  FinishGoalVC.swift
//  GoalPost-app
//
//  Created by Ethan  on 29/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var upWhenKbCalled: NSLayoutConstraint!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.delegate = self
        self.upWhenKbCalled.constant = 0
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyBoardHeight = keyboardRectangle.height
            self.upWhenKbCalled.constant = keyBoardHeight
        }
    }
    

    @IBAction func createBtnPressed(_ sender: Any) {
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    dismissDetail()
                }
            }
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompleteValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("successfully saved")
            completion(true)
        } catch {
            debugPrint(error)
            completion(false)
        }
    }
}
