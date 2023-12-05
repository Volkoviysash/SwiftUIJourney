//
//  Utils.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 21.11.2023.
//

import Foundation
import CoreImage
import UIKit

let sharedContext = CIContext(options: [.useSoftwareRenderer : false])

// MARK: - Utils
func convertUItoCI(from:UIImage) -> CIImage{
    let image = CIImage(image: from)!
    let fixedOriantationImage = image.oriented(forExifOrientation: imageOrientationToTiffOrientation(from.imageOrientation))
    return fixedOriantationImage
}
    
func imageOrientationToTiffOrientation(_ value: UIImage.Orientation) -> Int32 {
  switch value{
  case .up:
    return 1
  case .down:
    return 3
  case .left:
    return 8
  case .right:
    return 6
  case .upMirrored:
    return 2
  case .downMirrored:
    return 4
  case .leftMirrored:
    return 5
  case .rightMirrored:
    return 7
  default:
    return 1
  }
}

func resizedImage(at image: CIImage, scale: CGFloat, aspectRatio: CGFloat) -> CIImage? {
    
    let filter = CIFilter(name: "CILanczosScaleTransform")
    filter?.setValue(image, forKey: kCIInputImageKey)
    filter?.setValue(scale, forKey: kCIInputScaleKey)
    filter?.setValue(aspectRatio, forKey: kCIInputAspectRatioKey)
    
    return filter?.outputImage
}

public struct ParameterRange<T : Comparable, Target> {

  public let min: T
  public let max: T

  public init(min: T, max: T) {
    self.min = min
    self.max = max
  }
}
