//
//  BankAccount.swift
//  AccountEx
//
//  Created by JunYi on 9/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Foundation
import Intents

public class BankAccount {
    public class func allAccounts() -> [INPaymentAccount] {
        return [
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Frankie"), number: "******789", accountType: .saving, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 4893.93, currencyCode: "USD"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "JKK Investment"), number: "******321", accountType: .investment, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 1111.93, currencyCode: "GBP"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "BNM Everyday", spokenPhrase: "BNM Everyday", pronunciationHint: "BNM Everyday"), number: "******482", accountType: .debit, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 88123.93, currencyCode: "KRW"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "Bobbie", spokenPhrase: "Bobbie", pronunciationHint: "Bobbie"), number: nil, accountType: .debit, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 1234.56, currencyCode: "SGD"),secondaryBalance: INBalanceAmount(amount: 2974, balanceType: .miles))
        ]
    }
}
