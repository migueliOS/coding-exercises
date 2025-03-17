//
//  DesignEnvironmentValue.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import SwiftUI

private struct DesignKey: EnvironmentKey {
    static let defaultValue: AppDesign.Type = AppDesign.self
}

extension EnvironmentValues {
    var design: AppDesign.Type {
        get { self[DesignKey.self] }
        set { self[DesignKey.self] = newValue }
    }
}

extension View {
    
    /// Sets the design system in the environment
    func design(_ design: AppDesign.Type) -> some View {
        environment(\.design, design)
    }
}
