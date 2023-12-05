//
//  ContrastControl.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 21.11.2023.
//

import SwiftUI
import PixelEnginePackage

public struct FilterContrast: Equatable, Codable {
    public static let range: ParameterRange<Double, FilterContrast> = .init(min: -0.18, max: 0.18)
    public var value: Double = 0
    public init() { }
    
    public func apply(to image: CIImage, sourceImage: CIImage) -> CIImage {
        image
            .applyingFilter(
                "CIColorControls",
                parameters: [
                    kCIInputContrastKey: 1 + value,
                ]
            )
    }
}

struct ContrastControl: View {
    // Will be changed
    @StateObject var pectl: PECtl = PECtl()
    
    @State private var filterIntensity: Double = 0
    @State private var inputImage: CIImage?
    @State private var outputImage: CIImage?

    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.valueChanged()
            }
        )
        
        let min = FilterContrast.range.min
        let max = FilterContrast.range.max

        return VStack {
            FilterSlider(value: intensity, range: (min, max), defaultValue: 0)

            if let outputImage = outputImage {
                Image(uiImage: image(from: outputImage))
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
        }
        .onAppear {
            // Load your input image here, for example:
            self.inputImage = CIImage(image: pectl.originUI)
            self.valueChanged()
        }
    }

    // When value changes it triggers this function
    // This function applies new contrast to the image
    func valueChanged() {
        guard let inputImage = inputImage else { return }

        var filter = FilterContrast()
        filter.value = filterIntensity

        // Apply the contrast filter
        outputImage = filter.apply(to: inputImage, sourceImage: inputImage)
    }

    // This function makes UIImage from ciImage
    private func image(from ciImage: CIImage) -> UIImage {
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return UIImage()
        }
        return UIImage(cgImage: cgImage)
    }
}

struct ContrastControl_Previews: PreviewProvider {
    static var previews: some View {
        ContrastControl()
    }
}
