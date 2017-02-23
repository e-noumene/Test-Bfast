//
//  Utilities.swift
//  myvelib
//
//  Created by nicolas on 16/01/2016.
//  Copyright © 2016 nicolas. All rights reserved.
//

import Foundation
import UIKit



class Utilities {
    
    static func logDebug (_ myString: String) {
        if Parameters.TESTVERSION {
            if Parameters.RUNNINGONDEVICE {
                print("debug:" + myString)
            } else {
            NSLog("debug:" + myString)
            }
        }
    }
    
    static func logWarning (_ myString: String) {
        if Parameters.RUNNINGONDEVICE {
            print("⚡️warning⚡️:" + myString)
        } else {
            NSLog("⚡️warning⚡️:" + myString)

        }
    }
    
    static func logError (_ myString: String) {
        NSLog("💔error💔:" + myString)
    }
    
    
}






