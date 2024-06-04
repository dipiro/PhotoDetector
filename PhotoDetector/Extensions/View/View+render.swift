//
//  View+render.swift
//  PhotoDetector
//
//  Created by piro2 on 6/2/24.
//

import SwiftUI

extension View {
    @MainActor func render(scale displayScale: CGFloat = 1.0) -> UIImage? {
        let renderer = ImageRenderer(content: self)
        renderer.scale = displayScale
        return renderer.uiImage
    }
}
