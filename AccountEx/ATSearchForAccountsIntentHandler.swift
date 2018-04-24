//
//  ATSearchForAccountsIntentHandler.swift
//  AccountEx
//
//  Created by JunYi on 19/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Foundation
import Intents
import LocalAuthentication


class ATSearchForAccountsIntentHandler: NSObject, INSearchForAccountsIntentHandling {
    
    let accounts = BankAccount.allAccounts()
    var obtainedNickname: INSpeakableString?
    var obtainedAccountType: INAccountType?
    var authError: NSError?
    var result: INSpeakableStringResolutionResult?
    
    func resolveAccountNickname(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        
        obtainedNickname = intent.accountNickname
        obtainedAccountType = intent.accountType
        
        // Closure
        let x = {(success :Bool, evaluateError:Error?) -> Void in
            
            if success {
                authStatus = true;
                completion(self.proceedResolve())
                
            }
            else {
                guard let error = evaluateError else {
                    return
                }
                print(AuthController.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
                completion(INSpeakableStringResolutionResult.notRequired())
            }
        }
        
        // if not yet authenticated, go through authentication phase
        if !authStatus {
            
            // if touchID has been set up, proceed authentication with TouchID
            if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                AuthController.authenticationWithTouchID(callback: x)
            }
            
            // if touchID has not been set up, redirect to app
            else
            {
                print(AuthController.evaluateAuthenticationPolicyMessageForLA(errorCode: (authError?.code)!))
                completion(INSpeakableStringResolutionResult.notRequired())
            }
            
        }
            
        // if authenticated, proceed to resolve parameters
        else
        {
            completion(proceedResolve())
        }
    }
    
    func handle(intent: INSearchForAccountsIntent, completion: @escaping (INSearchForAccountsIntentResponse) -> Void) {
        
        var response = INSearchForAccountsIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
        // switch authStatus back to false after every handling session
        authStatus = false
        
        if let accountNickname = intent.accountNickname {
            response = INSearchForAccountsIntentResponse(code: .success, userActivity: nil)
            var matchedAccount = [INPaymentAccount]()
            
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
            // re-route to app if intent.accountNickname is invalid
            response = INSearchForAccountsIntentResponse(code: .failureCredentialsUnverified, userActivity: nil)
        }
        completion(response)
    }
    
    // create array of nicknames for disambiguation purposes
    func matchedNick() -> [INSpeakableString] {
        var matchedNick = [INSpeakableString]()
        for account in accounts {
            matchedNick.append(account.nickname!)
        }
        return matchedNick
    }
    
    // resolving the intent parameters, eventually narrowing down to one account nickname
    func proceedResolve() -> INSpeakableStringResolutionResult {
        var nickFound = false
        var result: INSpeakableStringResolutionResult
        
        if let accountNickname = obtainedNickname
        {
            for account in self.accounts
            {
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
