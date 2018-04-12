//
//  IntentHandler.swift
//  AccountEx
//
//  Created by JunYi on 9/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Intents
import LocalAuthentication

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any? {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        if intent is INSearchForAccountsIntent {
            print("Intent chosen")
            return ATSearchForAccountsIntentHandler()
        }
        
        return nil
    }
}

//extension IntentHandler {
//    func authenticationWithTouchID() {
//        let localAuthenticationContext = LAContext()
//        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
//
//        var authError: NSError?
//        let reasonString = "To access sensitive data"
//
//        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
//            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString) { success, evaluateError in
//
//                if success {
//
//                }
//                else {
//                    guard let error = evaluateError else {
//                        return
//                    }
//                    print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
//                }
//            }
//        } else {
//            guard let error = authError else {
//                return
//            }
//            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
//        }
//    }
//
//    func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
//        var message = ""
//        if #available(iOS 11.0, macOS 10.13, *) {
//            switch errorCode {
//            case LAError.biometryNotAvailable.rawValue:
//                message = "Authentication could not start because the device does not support biometric authentication"
//            case LAError.biometryLockout.rawValue:
//                message = "Authentication could not continue because the user has been locked out of biometric authentication"
//            case LAError.biometryNotEnrolled.rawValue:
//                message = "Authentication could not start because user has not enrolled in biometric authentication"
//            default:
//                message = "Did not find error code on LAError object"
//            }
//        }
//        else {
//            switch errorCode {
//            case Int(kLAErrorBiometryNotAvailable):
//                message = "TouchID is not available on this device"
//            case Int(kLAErrorBiometryLockout):
//                message = "Too many failed attempts"
//            case Int(kLAErrorBiometryNotEnrolled):
//                message = "TouchID is not enrolled on this device"
//            default:
//                message = "Did not find error code on LAError object"
//            }
//        }
//        return message
//    }
//
//    func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
//        var message = ""
//
//        switch errorCode {
//
//        case LAError.authenticationFailed.rawValue:
//            message = "The user failed to provide valid credentials"
//
//        case LAError.appCancel.rawValue:
//            message = "Authentication was cancelled by application"
//
//        case LAError.invalidContext.rawValue:
//            message = "The context is invalid"
//
//        case LAError.notInteractive.rawValue:
//            message = "Not interactive"
//
//        case LAError.passcodeNotSet.rawValue:
//            message = "Passcode is not set on the device"
//
//        case LAError.systemCancel.rawValue:
//            message = "Authentication was cancelled by the system"
//
//        case LAError.userCancel.rawValue:
//            message = "The user did cancel"
//
//        case LAError.userFallback.rawValue:
//            message = "The user chose to use the fallback"
//
//        default:
//            message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
//        }
//
//        return message
//    }
//}

