//
//  ShareViewController.swift
//  DataExtension
//
//  Created by MEEM on 13/06/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        
        if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem {
            for data in item.attachments! {
                let itemProvider = data as! NSItemProvider
                if (itemProvider.hasItemConformingToTypeIdentifier("public.jpeg")){
                    print("ItemProvider :::: \(itemProvider)")
                    itemProvider.loadItem(forTypeIdentifier: "public.jpeg", options: nil) { (item , error) in
                        
                            var imgData:Data!
                            if let url = item as? URL{
                                imgData = try! Data(contentsOf: url)
                            }
                            if let img = item as? UIImage{
                                imgData = UIImagePNGRepresentation(img)
                            }
                            
                            let dict:[String:Any] = ["imgData":imgData, "name":self.contentText]
                            let userDefault = UserDefaults(suiteName: "group.sushil.shareExtensionApp")
//                            userDefault?.addSuite(named: "group.sushil.shareExtensionApp")
                            userDefault?.set(dict, forKey: "img")
                            userDefault?.synchronize()
                    }
                }
            }
        }
        
        
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
