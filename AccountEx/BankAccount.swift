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
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "Joint Family"), number: "******789", accountType: .saving, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 4893.93, currencyCode: "USD"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(spokenPhrase: "JKK Investment"), number: "******321", accountType: .investment, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 1075.36, currencyCode: "USD"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "BNM 123 Gold Card", spokenPhrase: "BNM 123 Gold Card", pronunciationHint: "BNM 123 Gold Card"), number: "******482", accountType: .debit, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 88123.93, currencyCode: "KRW"),secondaryBalance: nil),
            INPaymentAccount(nickname: INSpeakableString(vocabularyIdentifier: "Last Resort", spokenPhrase: "Last Resort", pronunciationHint: "Last Resort"), number: nil, accountType: .debit, organizationName: INSpeakableString(spokenPhrase: "AYZ"), balance: INBalanceAmount(amount: 1234.56, currencyCode: "SGD"),secondaryBalance: INBalanceAmount(amount: 2974, balanceType: .miles))
        ]
    }
}
