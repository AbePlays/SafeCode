//
//  File.swift
//  SafeCode
//
//  Created by Abhishek Rawat on 13/08/23.
//

import Foundation
import SwiftUI

struct AppColors {
    @Environment(\.colorScheme) var colorScheme
    
    static var primary: Color {
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            return Color.white
        } else {
            return Color.black
        }
    }
}
