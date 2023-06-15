//
//  ViewExtension.swift
//  TopMovies
//
//  Created by Alicja Gruca on 15/06/2023.
//

import Foundation
import SwiftUI

extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}
