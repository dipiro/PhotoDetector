//
//  PhotoDetectingHandler.swift
//  PhotoDetector
//
//  Created by piro2 on 6/2/24.
//

import Foundation
import UIKit
import SwiftUI
import Vision

class PhotoDetectingHandler<Item: Hashable & DetectingProtocol> {
    private var results: [VNClassificationObservation]?
}

// MARK: - Public
extension PhotoDetectingHandler {
    @MainActor func detect(image: Image?) {
        guard let image = image,
              let uiImage: UIImage = image.render(),
              let ciImage = CIImage(image: uiImage),
              let model = try? VNCoreMLModel(for: Inceptionv3(configuration: .init()).model)
        else { return }
        
        
        let request = VNCoreMLRequest(model: model) { [weak self] (request, error) in
            self?.results = request.results as? [VNClassificationObservation]
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            try handler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func processResults() async -> [Item] {
        guard let results else { return [] }
        
        return results
            .prefix(Const.maxResults)
            .map { Item(from: $0) }
    }
}

// MARK: - Const
fileprivate struct Const {
    static let maxResults: Int = 5
}

