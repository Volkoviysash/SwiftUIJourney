//
//  BBMetalColorBlendFilter.swift
//  BBMetalImage
//
//  Created by Kaibo Lu on 4/5/19.
//  Copyright © 2019 Kaibo Lu. All rights reserved.
//

import Metal

/// Applies a color blend of two images
public class BBMetalColorBlendFilter: BBMetalBaseFilter {
    public init() { super.init(kernelFunctionName: "colorBlendKernel") }
}
