//
//  ATSearchForAccountsIntentHandler.swift
//  AccountEx
//
//  Created by JunYi on 9/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Foundation
import Intents
import LocalAuthentication

class ATSearchForAccountsIntentHandler: NSObject, INSearchForAccountsIntentHandling {
    
    let accounts = BankAccount.allAccounts()
    public var authenticatedStatus = false
    
    func resolveAccountNickname(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        
//        let authenticationBlock: (Bool) -> () = { authStatus in
//            if authStatus {
//                print(authStatus)
//                print("continue process")
//            }
//            else if !authStatus
//            {
//                print(authStatus)
//                print("stop everything")
//            }
//        }
//
//        func authen(doneAuthenBlock: (Bool) -> ()) {
//            doneAuthenBlock(AuthController.authenticationWithTouchID())
//        }
//
//        authen(doneAuthenBlock: authenticationBlock)
        
//        if !authenticatedStatus {
//            print("run authentication")
//            if AuthController.authenticationWithTouchID() {
//                authenticatedStatus = true
//            }
//            else {
//                print("error authen")
//            }
//            // authenticatedStatus = AuthController.authenticationWithTouchID()
//            print(authenticatedStatus)
//        }
//        else {
//            print("already true")
//        }

        if !authenticatedStatus {
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
            
            var authError: NSError?
            let reasonString = "To access sensitive data"
            
            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success, evaluateError) in
                    
                    if success {
                        self.authenticatedStatus = true
                        var nickFound = false
                        var result: INSpeakableStringResolutionResult
                        
                        print("Intent Nickname: \(String(describing: intent.accountNickname))")
                        print(intent)
                        if let accountNickname = intent.accountNickname
                        {
                            print("\(accountNickname)")
                            for account in self.accounts
                            {
                                print("\(account.nickname!)")
                                if accountNickname.spokenPhrase.lowercased() == account.nickname?.spokenPhrase.lowercased()
                                {
                                    nickFound = true
                                    break
                                }
                            }
                            
                            if nickFound
                            {
                                result = INSpeakableStringResolutionResult.success(with: intent.accountNickname!)
                            }
                            else
                            {
                                result = INSpeakableStringResolutionResult.disambiguation(with: self.matchedNick())
                            }
                        }
                        else
                        {
                            var matchedNickwithType = [INSpeakableString]()
                            var matchedAccount = [INPaymentAccount]()
                            
                            let accountType = intent.accountType
                            for account in self.accounts {
                                print("Checking accountType")
                                if accountType == account.accountType {
                                    matchedAccount.append(account)
                                }
                            }
                            
                            for account in matchedAccount
                            {
                                matchedNickwithType.append(account.nickname!)
                            }
                            
                            switch matchedNickwithType.count {
                            case 1...Int.max:
                                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNickwithType)
                            case 0:
                                result = INSpeakableStringResolutionResult.disambiguation(with: self.matchedNick())
                            default:
                                return
                            }
                        }
                        completion(result)
                        
                    }
                    else {
                        guard let error = evaluateError else {
                            return
                        }
                        print(AuthController.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    }
                })
            }
            else {
                guard let error = authError else {
                    return
                }
                print(AuthController.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
            }
        }
        else
        {
            var nickFound = false
            var result: INSpeakableStringResolutionResult
            
            print("Intent Nickname: \(String(describing: intent.accountNickname))")
            print(intent)
            if let accountNickname = intent.accountNickname
            {
                print("\(accountNickname)")
                for account in self.accounts
                {
                    print("\(account.nickname!)")
                    if accountNickname.spokenPhrase.lowercased() == account.nickname?.spokenPhrase.lowercased()
                    {
                        nickFound = true
                        break
                    }
                }
                
                if nickFound
                {
                    result = INSpeakableStringResolutionResult.success(with: intent.accountNickname!)
                }
                else
                {
                    result = INSpeakableStringResolutionResult.disambiguation(with: self.matchedNick())
                }
            }
            else
            {
                var matchedNickwithType = [INSpeakableString]()
                var matchedAccount = [INPaymentAccount]()
                
                let accountType = intent.accountType
                for account in self.accounts {
                    print("Checking accountType")
                    if accountType == account.accountType {
                        matchedAccount.append(account)
                    }
                }
                
                for account in matchedAccount
                {
                    matchedNickwithType.append(account.nickname!)
                }
                
                switch matchedNickwithType.count {
                case 1...Int.max:
                    result = INSpeakableStringResolutionResult.disambiguation(with: matchedNickwithType)
                case 0:
                    result = INSpeakableStringResolutionResult.disambiguation(with: self.matchedNick())
                default:
                    return
                }
            }
            completion(result)
        }
        
        
        
        
        
//        var nickFound = false
//        var result: INSpeakableStringResolutionResult
//
//        print("Intent Nickname: \(String(describing: intent.accountNickname))")
//        print(intent)
//        if let accountNickname = intent.accountNickname
//        {
//            print("\(accountNickname)")
//            for account in accounts
//            {
//                print("\(account.nickname!)")
//                if accountNickname.spokenPhrase.lowercased() == account.nickname?.spokenPhrase.lowercased()
//                {
//                    nickFound = true
//                    break
//                }
//            }
//
//            if nickFound
//            {
//                result = INSpeakableStringResolutionResult.success(with: intent.accountNickname!)
//            }
//            else
//            {
//                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick())
//            }
//        }
//        else
//        {
//            var matchedNickwithType = [INSpeakableString]()
//            var matchedAccount = [INPaymentAccount]()
//
//            let accountType = intent.accountType
//            for account in accounts {
//                print("Checking accountType")
//                if accountType == account.accountType {
//                    matchedAccount.append(account)
//                }
//            }
//
//            for account in matchedAccount
//            {
//                matchedNickwithType.append(account.nickname!)
//            }
//
//            switch matchedNickwithType.count {
//            case 1...Int.max:
//                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNickwithType)
//            case 0:
//                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick())
//            default:
//                return
//            }
//        }
//        completion(result)
    }
    
    func handle(intent: INSearchForAccountsIntent, completion: @escaping (INSearchForAccountsIntentResponse) -> Void) {
        
        print("handle")
        print(intent)
        var response = INSearchForAccountsIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
        
        if let accountNickname = intent.accountNickname {
            response = INSearchForAccountsIntentResponse(code: .success, userActivity: nil)
            var matchedAccount = [INPaymentAccount]()
            print("Handled Nickname: \(accountNickname)")
            
            for account in accounts {
                if accountNickname.spokenPhrase.lowercased() == account.nickname?.spokenPhrase.lowercased()
                {
                    matchedAccount.append(account)
                }
            }
            response.accounts = matchedAccount
        }
            
        else
        {
            response = INSearchForAccountsIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
        }
        completion(response)
    }
    
    func matchedNick() -> [INSpeakableString] {
        var matchedNick = [INSpeakableString]()
        for account in accounts {
            matchedNick.append(account.nickname!)
        }
        return matchedNick
    }
}
