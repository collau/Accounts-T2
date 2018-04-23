//
//  ViewController.swift
//  Accounts T2
//
//  Created by JunYi on 9/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import UIKit
import Intents
import AccountEx

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
        
//        let accounts = allAccounts()
//        let accountNames = accounts.map { $0.nickname!.spokenPhrase }
//        INVocabulary.shared().setVocabulary(NSOrderedSet(array: accountNames), of: .paymentsAccountNickname)
        
         registerVocabulary()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func allAccounts() -> [INPaymentAccount] {
        return [
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "Joint Family", spokenPhrase: "Joint Family", pronunciationHint: "Joint Family"), number: "******789", accountType: .saving, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 4893.93, currencyCode: "USD"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "JKK Investment", spokenPhrase: "JKK Investment", pronunciationHint: "jay kay kay investment"), number: "******321", accountType: .investment, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 1111.93, currencyCode: "GBP"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "BNM 123 Gold Card", spokenPhrase: "BNM 123 Gold Card", pronunciationHint: "BNM 123 Gold Card"), number: "******482", accountType: .debit, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 88123.93, currencyCode: "KRW"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Last Resort"), number: nil, accountType: .debit, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 1234.56, currencyCode: "SGD"),secondaryBalance: INBalanceAmount(amount: 2974, balanceType: .miles))
        ]
    }
    
    
    public func registerVocabulary() {
        let accounts = allAccounts()
        let accountNames = accounts.map { $0.nickname!.spokenPhrase }
        INVocabulary.shared().setVocabularyStrings(NSOrderedSet(array: accountNames), of: .paymentsAccountNickname)
        print("vocabulary registered")
    }
}



