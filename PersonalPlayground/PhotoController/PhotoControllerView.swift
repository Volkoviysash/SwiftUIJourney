//
//  PhotoControllerView.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 22.11.2023.
//

import SwiftUI

struct PhotoControllerView: View {
    @StateObject var vm = PhotoControllerVM()
    
    var body: some View {
        
        VStack(spacing: 10) {
            Image(uiImage: vm.editedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipped()
            
            ScrollView {
                VStack(spacing: 5) {
                    Group {
                        SettingsRow(
                            filterIntensity: $vm.whiteBalanceIntensity,
                            title: "White Balance",
                            min: 4000.0, max: 7000.0,
                            onValueChanged: { vm.process() }
                        )
                    }
                    
                    Group {
                        SettingsRow(
                            filterIntensity: $vm.expositionIntensity,
                            title: "Exposition",
                            min: -1.0, max: 1.0,
                            onValueChanged: { vm.process() }
                        )
                        
                        SettingsRow(
                            filterIntensity: $vm.contrastIntensity,
                            title: "Contrast",
                            min: 0.25, max: 1.75,
                            onValueChanged: { vm.process() }
                        )
                    }
                    
                    Group {
                        SettingsRow(
                            filterIntensity: $vm.saturationIntensity,
                            title: "Saturation",
                            min: 0.0, max: 2.0,
                            onValueChanged: { vm.process() }
                        )
                        
                        SettingsRow(
                            filterIntensity: $vm.colorfulnessIntensity,
                            title: "Colorfulness",
                            min: 1.0, max: 20.0,
                            onValueChanged: { vm.process() }
                        )
                    }
                    
                    Group {
                        SettingsRow(
                            filterIntensity: $vm.sharpnessIntensity,
                            title: "Sharpness",
                            min: -2.0, max: 2.0,
                            onValueChanged: { vm.process() }
                        )
                        
                        SettingsRow(
                            filterIntensity: $vm.burnoutIntensity,
                            title: "Burnout",
                            min: 0.0, max: 0.0025,
                            onValueChanged: { vm.process() }
                        )
                        
                        SettingsRow(
                            filterIntensity: $vm.vignettingIntensity,
                            title: "Vignetting",
                            min: 0.0, max: 0.7,
                            onValueChanged: { vm.process() }
                        )
                    }
                    
                    Group {
                        SettingsRow(
                            filterIntensity: $vm.hueIntensity,
                            title: "Hue",
                            min: 0.0, max: 360,
                            onValueChanged: { vm.process() }
                        )
                    }
                    
                    Group {
                        SettingsRow(
                            filterIntensity: $vm.shadowsIntensity,
                            title: "Shadows",
                            min: 0.0, max: 1.0,
                            onValueChanged: { vm.process() }
                        )
                        
                        SettingsRow(
                            filterIntensity: $vm.lightAreasIntensity,
                            title: "Light Areas",
                            min: 0.0, max: 1.0,
                            onValueChanged: { vm.process() }
                        )
                    }
                    
                    Group {
                        CustomColorPicker(colorSettings: $vm.colorSettings)
                        
                        SettingsRow(
                            filterIntensity: $vm.tintIntensity,
                            title: "Tint",
                            min: 0.0, max: 1.0,
                            onValueChanged: { vm.process() }
                        )
                        
                        SettingsRow(
                            filterIntensity: $vm.saturationIntensity,
                            title: "Saturation",
                            min: 0.0, max: 2.0,
                            onValueChanged: { vm.process() }
                        )
                        
                        SettingsRow(
                            filterIntensity: $vm.brightnessIntensity,
                            title: "Brightness",
                            min: -1.0, max: 1.0,
                            onValueChanged: { vm.process() }
                        )
                    }
                }
            }
        }
        .environmentObject(vm)
    }
    
    var GroupDivider: some View {
        Rectangle().fill(.black).frame(height: 2)
    }
}

struct SettingsRow: View {
    @EnvironmentObject var vm: PhotoControllerVM
    @Binding var filterIntensity: Double
    let title: String
    let min: Double
    let max: Double
    let onValueChanged: () -> Void
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                // Updates value and edits photo only if difference is more then 5%
                print("intensity value changed! to \($0)")
                let oldValue = self.filterIntensity
                let newValue = $0
                let percentageDifference = abs((oldValue - newValue) / oldValue)
                if percentageDifference > 0.05 {
                    self.filterIntensity = newValue
                    onValueChanged()
                }
            }
        )
        VStack(spacing: 0) {
            Text("\(title) \(String(format: "%.1f", filterIntensity))")
                .font(.headline)
            UISliderView(value: intensity, minValue: min, maxValue: max)
                
        }
        .padding(.horizontal)
    }
}

struct CustomColorPicker: View {
    @Binding var colorSettings: Color
    
    var body: some View {
        ColorPicker(selection: $colorSettings, supportsOpacity: false) {
            Text("Color Setting")
                .font(.headline)
        }
        .padding(.horizontal)
    }
}


struct PhotoControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.teal.opacity(0.5).ignoresSafeArea()
            PhotoControllerView()
        }
    }
}
