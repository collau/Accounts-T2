//
//  ATSearchForAccountsIntentHandler.swift
//  AccountEx
//
//  Created by JunYi on 9/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Foundation
import Intents

class ATSearchForAccountsIntentHandler: NSObject, INSearchForAccountsIntentHandling {
    
    let accounts = BankAccount.allAccounts()
    
    func resolveAccountNickname(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        
        var nickFound = false
        var result: INSpeakableStringResolutionResult
        var matchedNick = [INSpeakableString]()
        
        print("\(String(describing: intent.accountNickname))")
        if let accountNickname = intent.accountNickname?.spokenPhrase
        {
            for account in accounts
            {
                if accountNickname == (account.nickname?.spokenPhrase.lowercased())
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
                for account in accounts
                {
                    matchedNick.append(account.nickname!)
                }
                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick)
            }
        }
        else
        {
            var matchedNickwithType = [INSpeakableString]()
            var matchedAccount = [INPaymentAccount]()
            
            let accountType = intent.accountType
            for account in accounts {
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
                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick)
            default:
                return
            }
        }
        completion(result)
    }
    
    func handle(intent: INSearchForAccountsIntent, completion: @escaping (INSearchForAccountsIntentResponse) -> Void) {
        
        if let accountNickname = intent.accountNickname {
            let response = INSearchForAccountsIntentResponse(code: .success, userActivity: nil)
            var matchedNick = [INPaymentAccount]()
            
            for account in accounts {
                if accountNickname.spokenPhrase == account.nickname?.spokenPhrase.lowercased()
                {
                    matchedNick.append(account)
                }
            }
            
            response.accounts = matchedNick
            completion(response)
        }
        else
        {
            let response = INSearchForAccountsIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
            completion(response)
        }
    }
}
