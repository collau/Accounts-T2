//
//  ATSearchForAccountsIntentHandler2.swift
//  AccountEx
//
//  Created by JunYi on 19/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Foundation
import Intents
import LocalAuthentication


class ATSearchForAccountsIntentHandler2: NSObject, INSearchForAccountsIntentHandling {
    
    let accounts = BankAccount.allAccounts()
    var obtainedNickname: INSpeakableString?
    var obtainedAccountType: INAccountType?
    var result: INSpeakableStringResolutionResult?
    
//    let z = {(success :Bool, evaluateError: Error?) -> Void in
//        if success {
//            authStatus = true;
//            print("from method z")
//        }
//        else {
//            guard let error = evaluateError else {
//                return
//            }
//            authStatus = false
//            // completion(INSpeakableStringResolutionResult.notRequired())
//        }
//    }

    
    
    
    
    func resolveAccountNickname(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        
        print("Intent is: " + "\(intent)")
        print("\(authStatus) from resolveAccountNickname")
        obtainedNickname = intent.accountNickname
        obtainedAccountType = intent.accountType
        
    
        
        
        // Closure
        let x = {(success :Bool, evaluateError:Error?) -> Void in

            if success {
                authStatus = true;
                print("x, success")
                completion(self.proceedResolve())

            }
            else {
                guard let error = evaluateError else {
                    return
                }
                print("if yes biometrics")
                print(AuthController.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                completion(INSpeakableStringResolutionResult.notRequired())
            }
        }
        
        
        
        
        
        
        
        if !authStatus {
            if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                AuthController.authenticationWithTouchID(callback: x)
            }
            else
            {
                completion(INSpeakableStringResolutionResult.notRequired())
            }
            
            
//            let localAuthenticationContext = LAContext()
//            localAuthenticationContext.localizedFallbackTitle = "" // set to empty string if fallback option is not needed
//            var authError: NSError?
//            let reasonString = "To access sensitive data"
//
//            if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
//                localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success, evaluateError) in
//
//                    x(success, evaluateError);
//                })
//            }
//            else {
//                guard let error = authError else {
//                    return
//                }
//                print("if no biometrics")
//                print(AuthController.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
//                completion(INSpeakableStringResolutionResult.notRequired())
//            }
        }
        else
        {
            print("function works?!")
             completion(proceedResolve())
        }
//        completion(proceedResolve())
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
    
    func proceedResolve() -> INSpeakableStringResolutionResult {
        var nickFound = false
        var result: INSpeakableStringResolutionResult
        
        print("Intent Nickname: \(String(describing: obtainedNickname))")
        if let accountNickname = obtainedNickname
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
                result = INSpeakableStringResolutionResult.success(with: obtainedNickname!)
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
            
            let accountType = obtainedAccountType
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
                result = INSpeakableStringResolutionResult.needsValue()
            }
        }
        return result
    }
}
