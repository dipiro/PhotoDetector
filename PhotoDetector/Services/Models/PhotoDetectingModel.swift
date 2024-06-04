//
//  PhotoDetectingModel.swift
//  PhotoDetector
//
//  Created by piro2 on 6/2/24.
//

import Foundation
import Vision

struct PhotoDetectingModel: PhotoDetectingDataSource {
    var id: String = UUID().uuidString
    var description: String
    var level: Float
    
    var roundedLevel: String {
        let scaledNumber = level * 100
        let roundedNumber = round(scaledNumber * 10) / 10
        return "\(String(format: "%.1f", roundedNumber))%"
    }
    
    // MARK: - Init
    init(description: String, level: Float) {
        self.description = description
        self.level = level
    }
    
    init(from observation: VNClassificationObservation) {
        self.description = observation.identifier
        self.level = observation.confidence
    }
}
