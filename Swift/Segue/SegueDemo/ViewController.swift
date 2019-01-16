//
//  ViewController.swift
//  SegueDemo
//
//  Created by Ethan  on 16/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pressToP1(_ sender: Any) {
        self.performSegue(withIdentifier: "goP1Segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goP1Segue" {
            let controller = segue.destination as! ViewController2
            controller.str = textField.text
        }
    }
    
    @IBAction func getSegue(segue : UIStoryboardSegue){
        if segue.identifier == "passValue" {
            let vcSource = segue.source as! ViewController2
            self.label.text = vcSource.backTextfField.text
        }
    }
    
}
