//
//  AppDesign.swift
//  SampleProject
//
//  Created by Miguel Lorenzo on 18/3/2025.
//

import Foundation

import SwiftUI

enum AppDesign {
    
    private enum FontSize: CGFloat {
        case small = 14
        case medium = 16
        case large = 24
    }
    
    private enum Colors: String {
        case backgroundDefault = "BackgroundDefault"
        case backgroundSecondary = "BackgroundSecondary"
        case foregroundDefault = "ForegroundDefault"
        case foregroundSecondary = "ForegroundSecondary"
        case brand = "Brand"
        
    }
    
    // MARK: - Public
    
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 32
    }
    
    struct CornerRadius {
        static let standard: CGFloat = 8
        static let rounded: CGFloat = 16
    }
    
    enum Semantic {
        
        enum Colors {
            static var viewPrimaryBackground: Color {
                Color(AppDesign.Colors.backgroundDefault.rawValue)
            }
            
            static var viewSecondaryBackground: Color {
                Color(AppDesign.Colors.backgroundSecondary.rawValue)
            }
            
            static var buttonPrimaryBackground: Color {
                Color(AppDesign.Colors.brand.rawValue)
            }
            
            static var text: Color {
                Color(AppDesign.Colors.foregroundDefault.rawValue)
            }
            
            static var textSecondary: Color {
                Color(AppDesign.Colors.foregroundSecondary.rawValue)
            }
        }
        
        enum Fonts {
            static var title: UIFont {
                return UIFontMetrics(forTextStyle: .title1)
                    .scaledFont(for: UIFont.systemFont(ofSize: AppDesign.FontSize.large.rawValue, weight: .bold))
            }
            
            static var subtitle: UIFont {
                return UIFontMetrics(forTextStyle: .title2)
                    .scaledFont(for: UIFont.systemFont(ofSize: AppDesign.FontSize.medium.rawValue, weight: .semibold))
            }
            
            static var body: UIFont {
                return UIFontMetrics(forTextStyle: .body)
                    .scaledFont(for: UIFont.systemFont(ofSize: AppDesign.FontSize.small.rawValue, weight: .regular))
            }
        }
    }
}
