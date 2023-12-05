//
//  UISliderView.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 22.11.2023.
//

import SwiftUI

struct UISliderView: UIViewRepresentable {
    @Binding var value: Double
    
    var minValue = 1.0
    var maxValue = 100.0
    var thumbColor: UIColor = .white
    var minTrackColor: UIColor = .white
    var maxTrackColor: UIColor = .white
    var rounded: Bool = false
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        var rounded: Bool
        
        init(value: Binding<Double>, rounded: Bool) {
            self.value = value
            self.rounded = rounded
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            if self.rounded {
                self.value.wrappedValue = Double(sender.value).rounded()
            } else {
                self.value.wrappedValue = Double(sender.value)
            }
        }
    }
    
    func makeCoordinator() -> UISliderView.Coordinator {
        Coordinator(value: $value, rounded: rounded)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.value = Float(value)
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}


struct UISliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.opacity(0.4).ignoresSafeArea()
            
            UISliderView(value: .constant(50.0))
                .padding()
                .previewLayout(.sizeThatFits)
        }
    }
}
