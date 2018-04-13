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
    public var authenticatedStatus = false
    
    func resolveAccountNickname(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        
        print("Authentication Step")
        AuthController.authenticationWithTouchID()

        var nickFound = false
        var result: INSpeakableStringResolutionResult
        var matchedNick = [INSpeakableString]()
        for account in accounts {
            matchedNick.append(account.nickname!)
        }

        print("Intent Nickname: \(String(describing: intent.accountNickname))")
        print(intent)
        if let accountNickname = intent.accountNickname
        {
            print("\(accountNickname)")
            for account in accounts
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
                result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick)
            }
        }
            
                
//        else if let orgName = intent.organizationName
//        {
//        var matchedAcct: INSpeakableString?
//            for account in accounts
//            {
//                if orgName.spokenPhrase.lowercased() == account.nickname?.spokenPhrase.lowercased()
//                {
//                    nickFound = true
//                    matchedAcct = account.nickname!
//                    break
//                }
//            }
//            if nickFound
//            {
//                result = INSpeakableStringResolutionResult.success(with: matchedAcct!)
//            }
//            else
//            {
//                var matchedNickwithType = [INSpeakableString]()
//                var matchedAccount = [INPaymentAccount]()
//
//                let accountType = intent.accountType
//                for account in accounts {
//                    print("Checking accountType")
//                    if accountType == account.accountType {
//                        matchedAccount.append(account)
//                    }
//                }
//
//                for account in matchedAccount
//                {
//                    matchedNickwithType.append(account.nickname!)
//                }
//
//                switch matchedNickwithType.count {
//                case 1...Int.max:
//                    result = INSpeakableStringResolutionResult.disambiguation(with: matchedNickwithType)
//                case 0:
//                    result = INSpeakableStringResolutionResult.disambiguation(with: matchedNick)
//                default:
//                    return
//                }
//            }
//        }
            
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
        
        print(intent)
        var response = INSearchForAccountsIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
        
        if let accountNickname = intent.accountNickname {
            response = INSearchForAccountsIntentResponse(code: .success, userActivity: nil)
            var matchedNick = [INPaymentAccount]()
            print("Handled Nickname: \(accountNickname)")
            
            for account in accounts {
                if accountNickname.spokenPhrase.lowercased() == account.nickname?.spokenPhrase.lowercased()
                {
                    matchedNick.append(account)
                }
            }
            response.accounts = matchedNick
        }
            
        else
        {
            response = INSearchForAccountsIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil)
        }
        completion(response)
    }
}


//    func resolveOrganizationName(for intent: INSearchForAccountsIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
//
//        var orgFound = false
//        var result: INSpeakableStringResolutionResult
//        var matchedAcct: INSpeakableString?
//        var matchedOrg = [INSpeakableString]()
//        for account in accounts {
//            matchedOrg.append(account.nickname!)
//        }
//
//        print("\(String(describing: intent.organizationName))")
//        print("\(String(describing: intent.organizationName))")
//        print(intent)
//        if let orgName = intent.organizationName?.spokenPhrase
//        {
//            for account in accounts
//            {
//                if orgName == account.organizationName?.spokenPhrase
//                {
//                    orgFound = true
//                    matchedAcct = account.nickname!
//                    break
//                }
//            }
//            if orgFound
//            {
//                result = INSpeakableStringResolutionResult.success(with: matchedAcct!)
//            }
//            else
//            {
//                result = INSpeakableStringResolutionResult.disambiguation(with: matchedOrg)
//            }
//        }
//        else
//        {
//            var matchedOrgwithType = [INSpeakableString]()
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
//                matchedOrgwithType.append(account.nickname!)
//            }
//
//            switch matchedOrgwithType.count {
//            case 1...Int.max:
//                result = INSpeakableStringResolutionResult.disambiguation(with: matchedOrgwithType)
//            case 0:
//                result = INSpeakableStringResolutionResult.disambiguation(with: matchedOrg)
//            default:
//                return
//            }
//        }
//        completion(result)
//    }
