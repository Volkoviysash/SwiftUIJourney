//
//  SoundEffectView.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 29.11.2023.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
    }
    
    func playSound(_ sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    
}

struct SoundEffectView: View {
    var soundManager = SoundManager.instance
    
    var body: some View {
        VStack(spacing: 40) {
            Button("Play Sound TaDa") {
                soundManager.playSound(.tada)
            }
            
            Button("Play Sound BaDum") {
                soundManager.playSound(.badum)
            }
        }
    }
}

struct SoundEffectView_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffectView()
    }
}
