//
//  ViewController2.swift
//  SegueDemo
//
//  Created by Ethan  on 16/1/19.
//  Copyright © 2019 Ethan . All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backTextfField: UITextField!
    var str : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.text = str
        // Do any additional setup after loading the view.
    }
    @IBAction func backBtn(_ sender: Any) {
//        self.presentingViewController!.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "passValue", sender: nil)
    }
    
    

    
}
