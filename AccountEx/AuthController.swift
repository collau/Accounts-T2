//
//  AuthController.swift
//  AccountEx
//
//  Created by JunYi on 12/4/18.
//  Copyright © 2018 dzhi. All rights reserved.
//

import Foundation
import LocalAuthentication

public class AuthController {
    
    // only if TouchID is available - availability determined in ATSearchForAccountsIntentHandler
    public class func authenticationWithTouchID(callback: @escaping (Bool, Error?) -> Void) {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = ""
        let reasonString = "To access sensitive data"
        
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success, evaluateError) in
                
                callback(success, evaluateError)
                print("auth success! status is now \(authStatus)")
                
            })
        }

    
    public class func evaluatePolicyFailErrorMessageForLA(errorCode: Int) -> String {
        var message = ""
        if #available(iOS 11.0, macOS 10.13, *) {
            switch errorCode {
            case LAError.biometryNotAvailable.rawValue:
                message = "Authentication could not start because the device does not support biometric authentication"
            case LAError.biometryLockout.rawValue:
                message = "Authentication could not continue because the user has been locked out of biometric authentication"
            case LAError.biometryNotEnrolled.rawValue:
                message = "Authentication could not start because user has not enrolled in biometric authentication"
            default:
                message = "Did not find error code on LAError object"
            }
        }
        else {
            switch errorCode {
            case Int(kLAErrorBiometryNotAvailable):
                message = "TouchID is not available on this device"
            case Int(kLAErrorBiometryLockout):
                message = "Too many failed attempts"
            case Int(kLAErrorBiometryNotEnrolled):
                message = "TouchID is not enrolled on this device"
            default:
                message = "Did not find error code on LAError object"
                }
            }
            return message
        }
        
        public class func evaluateAuthenticationPolicyMessageForLA(errorCode: Int) -> String {
            var message = ""
            
            switch errorCode {
                
            case LAError.authenticationFailed.rawValue:
                message = "The user failed to provide valid credentials"
                
            case LAError.appCancel.rawValue:
                message = "Authentication was cancelled by application"
                
            case LAError.invalidContext.rawValue:
                message = "The context is invalid"
                
            case LAError.notInteractive.rawValue:
                message = "Not interactive"
                
            case LAError.passcodeNotSet.rawValue:
                message = "Passcode is not set on the device"
                
            case LAError.systemCancel.rawValue:
                message = "Authentication was cancelled by the system"
                
            case LAError.userCancel.rawValue:
                message = "The user did cancel"
                
            case LAError.userFallback.rawValue:
                // errorCode == -3
                message = "The user chose to use the fallback"
                
            default:
                message = evaluatePolicyFailErrorMessageForLA(errorCode: errorCode)
            }
            
            return message
    }
}
