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
    
    func resolveAccountNickname(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        
        print("Intent is: " + "\(intent)")
        print(authStatus)

        if !authStatus {
            let localAuthenticationContext = LAContext()
            localAuthenticationContext.localizedFallbackTitle = "" // set to empty string if fallback option is not needed
            
            var authError: NSError?
            let reasonString = "To access sensitive data"
            let x = {(success :Bool, evaluateError:Error?) -> Void in
                var result: INSpeakableStringResolutionResult
                
                if success {
                    authStatus = true
                    var nickFound = false
                    
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
                    print("if success")
                    print(AuthController.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                    
                    result = INSpeakableStringResolutionResult.notRequired()
                    completion(result)
                    //TODO: Insert closure here
                }
            }
            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success, evaluateError) in
                    
                    x(success, evaluateError);
                })
            }
            else {
                guard let error = authError else {
                    return
                }
                print("if cannot evaluate")
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
        authStatus = false
        
        if let accountNickname = intent.accountNickname {
            // response = INSearchForAccountsIntentResponse(code: .failureCredentialsUnverified, userActivity: nil)
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
            response = INSearchForAccountsIntentResponse(code: .failureCredentialsUnverified, userActivity: nil)
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
