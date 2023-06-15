//
//  DeviceShakeViewModifier.swift
//  TopMovies
//
//  Created by Alicja Gruca on 15/06/2023.
//

import Foundation
import SwiftUI

struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}
