//
//  PhotoControllerVM.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 22.11.2023.
//

import Foundation
import UIKit
import BBMetalImage
import SwiftUI

final class PhotoControllerVM: ObservableObject {
    @Published var whiteBalanceIntensity: Double = 5000.0
    @Published var expositionIntensity: Double = 0.0
    @Published var contrastIntensity: Double = 1.0
    @Published var saturationIntensity: Double = 1.0
    @Published var colorfulnessIntensity: Double = 10.0
    @Published var sharpnessIntensity: Double = 0.0
    @Published var burnoutIntensity: Double = 0.0
    @Published var vignettingIntensity: Double = 0.7
    @Published var hueIntensity: Double = 0.0
    @Published var shadowsIntensity: Double = 0.0
    @Published var lightAreasIntensity: Double = 1.0
    @Published var quantizationLevels: Double = 10.0
    
    @Published var colorSettings: Color = .white
    @Published var tintIntensity: Double = 0.0
    
    @Published var brightnessIntensity: Double = 0.0
    
    var originalImage: UIImage!
    @Published var editedImage: UIImage
    private var imageSource: BBMetalStaticImageSource?
    
    init() {
        self.originalImage = UIImage(named: "boy")
        self.editedImage = self.originalImage
        setupImageSource()
    }
    
    private func setupImageSource() {
        guard let originalImage = originalImage else { return }
        imageSource = BBMetalStaticImageSource(image: originalImage)
    }
 
    func process() {
        guard let imageSource = imageSource else { return }
//        autoreleasepool {
//            // Set up all filters
            let whiteBalanceFilter = BBMetalWhiteBalanceFilter(temperature: Float(whiteBalanceIntensity))
            let exposureFilter = BBMetalExposureFilter(exposure: Float(expositionIntensity))
            let saturationFilter = BBMetalSaturationFilter(saturation: Float(saturationIntensity))
            let colorfulnessFilter = BBMetalPosterizeFilter(colorLevels: Float(colorfulnessIntensity))
            let sharpnessFilter = BBMetalSharpenFilter(sharpeness: Float(sharpnessIntensity))
            let vignettingFilter = BBMetalVignetteFilter(start: Float(vignettingIntensity))
            let hueFilter = BBMetalHueFilter(hue: Float(hueIntensity))
            let shadowsFilter = BBMetalHighlightShadowFilter(shadows: Float(shadowsIntensity))
            let lightAreasFilter = BBMetalHighlightShadowFilter(highlights: Float(lightAreasIntensity))


            let bbСolor = BBMetalColor(
                red: colorSettings.red,
                green: colorSettings.green,
                blue: colorSettings.blue)        
            let tintFilter = BBMetalMonochromeFilter(
                color: bbСolor,
                intensity: Float(tintIntensity)
            )

            let brightnessFilter = BBMetalBrightnessFilter(brightness: Float(brightnessIntensity))
            let burnoutFilter = BBMetalMonochromeFilter(color: BBMetalColor(red: 206, green: 200, blue: 114), intensity: Float(burnoutIntensity))

            var contrastFilter: BBMetalBaseFilter? = BBMetalContrastFilter(contrast: Float(contrastIntensity))

            imageSource.removeAllConsumers()

            imageSource
                .add(consumer: whiteBalanceFilter)
                .add(consumer: exposureFilter)
                .add(consumer: saturationFilter)
                .add(consumer: colorfulnessFilter)
                .add(consumer: sharpnessFilter)
                .add(consumer: burnoutFilter)
                .add(consumer: vignettingFilter)
                .add(consumer: hueFilter)
                .add(consumer: shadowsFilter)
                .add(consumer: lightAreasFilter)
                .add(consumer: tintFilter)
                .add(consumer: brightnessFilter)
                .add(consumer: contrastFilter!)
                
                .addCompletedHandler { [weak self] _ in
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        // TODO: CHANGE TO THE LAST FILTER
                        if let filteredImage = contrastFilter?.outputTexture?.bb_image {
                            self.editedImage = filteredImage
                            contrastFilter = nil
                        }

                    }
                }

            // Start processing
            imageSource.transmitTexture()
//        }
    }
}
