//
//  NewRideViewModel.swift
//  SUI Koober
//
//  Created by Miguel Lorenzo on 17/3/2025.
//  Copyright © 2025 Razeware. All rights reserved.
//

import Foundation
import SwiftUI

enum NewRideDestinations: Hashable, Decodable {
    case dropOffLocation
}

@available(iOS 16.0, *)
class NewRideViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var navigationPath = NavigationPath()
    let userSession: UserSession
    
    // MARK: - Initialization
    
    init(userSession: UserSession) {
        self.userSession = userSession
    }
}
