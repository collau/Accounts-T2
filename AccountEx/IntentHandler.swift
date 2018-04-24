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
        
        // ATSearchForAccountsIntentHandler2 is a unclean version for further development
        let accountSearchHandler = ATSearchForAccountsIntentHandler()
        
        if intent is INSearchForAccountsIntent {
            // if the intentSession is similar to previous, the session has been authenticated before
            if (self.hash == intentSession) {
                authStatus = true
            }
            else
            {
                authStatus = false
            }
            
            // to set the hash value of the intent session for every Siri conversation
            intentSession = self.hash
            return accountSearchHandler
        }
        return nil
    }
}

