//
//  ViewController.swift
//  ShareExtensionApp
//
//  Created by MEEM on 13/06/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var textLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefault = UserDefaults(suiteName: "group.sushil.shareExtensionApp")
       
        if let dict = userDefault?.value(forKey: "img") as? NSDictionary {
            if let imgData = dict.value(forKey: "imgData"){
                if  let text = dict.value(forKey: "name"){
                    pic.image = UIImage(data: imgData as! Data)
                    textLabel.text = text as? String
                }
            }

            userDefault?.removeObject(forKey: "img")
            userDefault?.synchronize()
            
        }
    }
}

