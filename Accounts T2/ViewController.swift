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
        
        let accounts = allAccounts()
        let accountNames = accounts.map { $0.nickname! }
        INVocabulary.shared().setVocabularyStrings(NSOrderedSet(array: accountNames), of: .paymentsAccountNickname)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func allAccounts() -> [INPaymentAccount] {
        return [
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Green Account"), number: "******789", accountType: .saving, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 4893.93, currencyCode: "USD"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "JKK Investment"), number: "******321", accountType: .investment, organizationName: INSpeakableString(spokenPhrase: "JKK"), balance: INBalanceAmount(amount: 1111.93, currencyCode: "GBP"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "BNM Card", spokenPhrase: "BNM Card", pronunciationHint: "BNM Card"), number: "******482", accountType: .debit, organizationName: INSpeakableString(spokenPhrase: "BNM"), balance: INBalanceAmount(amount: 88123.93, currencyCode: "KRW"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "Orange 2", spokenPhrase: "Orange 2", pronunciationHint: "Orange 2"), number: nil, accountType: .debit, organizationName: INSpeakableString(spokenPhrase: "TZ"), balance: INBalanceAmount(amount: 1234.56, currencyCode: "SGD"),secondaryBalance: INBalanceAmount(amount: 2974, balanceType: .miles))
        ]
    }
    
    
    public func registerVocabulary() {
        let accounts = allAccounts()
        let accountNames = accounts.map { $0.nickname! }
        INVocabulary.shared().setVocabularyStrings(NSOrderedSet(array: accountNames), of: .paymentsAccountNickname)
    }
}



