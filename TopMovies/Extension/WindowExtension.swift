//
//  WindowExtension.swift
//  TopMovies
//
//  Created by Alicja Gruca on 15/06/2023.
//

import Foundation
import UIKit

extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}
