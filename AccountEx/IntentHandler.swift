//
//  IntentHandler.swift
//  AccountEx
//
//  Created by JunYi on 9/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Intents
import LocalAuthentication

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"
internal var authStatus = false

class IntentHandler: INExtension {
    
    var intentSession: Int = 1
    
    override func handler(for intent: INIntent) -> Any? {
        
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        let accountSearchHandler = ATSearchForAccountsIntentHandler2()
        
        if intent is INSearchForAccountsIntent {
            if (self.hash == intentSession) {
                authStatus = true
            }
            else
            {
                authStatus = false
            }
            print(self.hash)
            print("\(authStatus) from IntentHandler class")
            intentSession = self.hash
            return accountSearchHandler
        }
        return nil
    }
}

