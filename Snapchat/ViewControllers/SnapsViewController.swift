//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Joey Newfield on 1/14/18.
//  Copyright © 2018 Joey Newfield. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    
}
