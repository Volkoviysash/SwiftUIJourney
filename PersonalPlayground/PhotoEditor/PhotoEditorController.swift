//
//  PhotoEditorController.swift
//  PersonalPlayground
//
//  Created by Alexandr Volkovich on 21.11.2023.
//

import Foundation
import UIKit

class PECtl : ObservableObject{
    static var shared = PECtl()
    
    init() {
        print("init PECtl")
    }
        
    // MARK: - Images
    // original image
    var originUI: UIImage! = UIImage(named: "boy")
    // cache origin: conver from UI to CI
    var originCI: CIImage!
    // Image preview: will update after edited
    @Published var outputImage: CIImage?
       
    
    // This function makes UIImage from ciImage
    func image(from ciImage: CIImage) -> UIImage {
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return UIImage()
        }
        return UIImage(cgImage: cgImage)
    }
}

