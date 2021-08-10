//
//  UIDeviceExtension.swift
//  APIWarpper
//
//  Created by Talish George on 01/07/21.
//

import UIKit

enum DeviceHeightRange {
    case lower//iPhone 5s, SE
    case medium// iPhone 8
    case higher// iPhone XS, 8 Plus
    case extreme// iPhone XS Max XR
    
    private static let range1 = 1
    private static let range2 = 569
    private static let range3 = 668
    private static let range4 = 813
    
    static func current() -> DeviceHeightRange {
        switch Int(UIScreen.main.bounds.height) {
        case range1 ..< range2:
            return .lower
        case range2 ..< range3:
            return .medium
        case range3 ..< range4:
            return .higher
        default:
            return .extreme
        }
    }
}
