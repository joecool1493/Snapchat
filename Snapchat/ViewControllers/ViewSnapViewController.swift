//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Joey Newfield on 1/16/18.
//  Copyright © 2018 Joey Newfield. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
    }

    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("snaps").child(snap.key).removeValue()
        
        Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("we deleted the pic")
        }
    }
   

}
