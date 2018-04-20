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
    
    
    
    public class func authenticationWithTouchID(callback: @escaping (Bool, Error?) -> Void) {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Use Passcode"
        var authError: NSError?
        let reasonString = "To access sensitive data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError)
            // is it possible to authenticate with biometric? yes
        
        {
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {(success, evaluateError) in
                
//                ATSearchForAccountsIntentHandler2().z(success, evaluateError)
                callback(success, evaluateError)
                print("auth success! status is now \(authStatus)")
                
//                if success {
//                    // User authenticated successfully, take appropriate action
//                    print("touchID OK")
//                }
//                else {
//                    guard let error = evaluateError else {
//                        return
//
//                    }
//                    // User did not authenticate successfully, look at error and take appropriate action
//                    print(evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
//
//                }
            })
        }
            
            
        else
        {
            guard let error = authError else {
                return
            }
            print(evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
        }
//        else {
//            guard let error = authError else {
//                return
//            }
//            // Could not evaluate touchID policy; look at authError and present appropriate message to user
//            print(self.evaluateAuthenticationPolicyMessageForLA(errorCode: error.code))
//
//            // In this case, activate authentication using passcode
//            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reasonString, reply: {  success, evaluateError in
//
//                if success {
//                    // Successful authentication using passcode
//                }
//                else {
//                    guard let error = evaluateError else {
//                        return
//                    }
//                    // Unsuccessful authentication using passcode
//                    print(evaluateAuthenticationPolicyMessageForLA(errorCode: error._code))
//                }
//            })
//        }
    

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
