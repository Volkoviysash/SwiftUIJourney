//
//  Haptics.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 29.11.2023.
//

import UIKit
import SwiftUI


class HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
        print("- Notification")
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
        print("- Impact")
    }
}

struct HapticsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Success") { HapticManager.instance.notification(type: .success) }
            Button("Warning") { HapticManager.instance.notification(type: .warning) }
            Button("Error") { HapticManager.instance.notification(type: .error) }
            
            Divider()
            
            Button("soft") { HapticManager.instance.impact(style: .soft) }
            Button("light") { HapticManager.instance.impact(style: .light) }
            Button("medium") { HapticManager.instance.impact(style: .medium) }
            Button("rigid") { HapticManager.instance.impact(style: .rigid) }
            Button("heavy") { HapticManager.instance.impact(style: .heavy) }
            
        }
    }
}

struct HapticsView_Previews: PreviewProvider {
    static var previews: some View {
        HapticsView()
    }
}
