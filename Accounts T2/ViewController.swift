//
//  ViewController.swift
//  Accounts T2
//
//  Created by JunYi on 9/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        INPreferences.requestSiriAuthorization { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                print("Authorized")
            default:
                print("Unauthorized")
            }
        }
        
        let accountNames: NSOrderedSet = ["BNM 123", "Standard"]
        INVocabulary.shared().setVocabularyStrings(accountNames, of: .paymentsAccountNickname)
        
//        registerVocabulary()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

func registerVocabulary() {
    let accountNames: NSOrderedSet = ["BNM 123", "Standard Account"]
    INVocabulary.shared().setVocabularyStrings(accountNames, of: .paymentsAccountNickname)
}

