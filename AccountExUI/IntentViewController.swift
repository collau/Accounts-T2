//
//  IntentViewController.swift
//  AccountExUI
//
//  Created by JunYi on 9/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import IntentsUI
import AccountEx

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    
    @IBOutlet weak var paramTV: UITextView!
    @IBOutlet weak var paramLabel: UILabel!
    @IBOutlet weak var accountTV: UITextView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.

        
        // Define parameters
        let accountNickname = INParameter(for: INSearchForAccountsIntentResponse.self, keyPath: #keyPath(INSearchForAccountsIntentResponse.accounts.nickname))
        
        let account = INParameter(for: INSearchForAccountsIntentResponse.self, keyPath: #keyPath(INSearchForAccountsIntentResponse.accounts))
        
        let organizationName = INParameter(for: INSearchForAccountsIntentResponse.self, keyPath: #keyPath(INSearchForAccountsIntentResponse.accounts.organizationName))
        
        let accountNicknameValue = interaction.parameterValue(for: accountNickname)
        
        let accountBalance = INParameter(for: INSearchForAccountsIntentResponse.self, keyPath: #keyPath(INSearchForAccountsIntentResponse.accounts.balance.amount))
        
        // Handle parameters
        if parameters.count > 0 {
            let nicknames = interaction.parameterValue(for: accountNickname) as? String!
            let ballance = interaction.parameterValue(for: accountBalance) as? NSDecimalNumber
            let intent = interaction.intentResponse as! INSearchForAccountsIntentResponse
            let acctBal = intent.accounts![0].balance?.amount?.doubleValue

            paramLabel.text = "\((intent.accounts![0].nickname?.spokenPhrase)!)"
            balanceLabel.text = "\(acctBal!)"
//            accountLabel.text = "\((intent.accounts![0].nickname?.spokenPhrase)!)"
//            balanceLabel.text = "\(acctBal!)"
            completion(true, [account], self.desiredSize)
        }
        else
        {
            completion(false, [], CGSize.zero)
        }
    }
    
    var desiredSize: CGSize {
        let size = self.extensionContext!.hostedViewMaximumAllowedSize
        return CGSize.init(width: size.width, height: 150)
//        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
