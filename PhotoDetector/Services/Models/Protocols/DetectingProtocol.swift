//
//  DetectingProtocol.swift
//  PhotoDetector
//
//  Created by piro2 on 6/2/24.
//

import Foundation
import Vision

protocol DetectingProtocol: Hashable, Identifiable {
    init(from observation: VNClassificationObservation)
}

protocol PhotoDetectingDataSource: DetectingProtocol {
    var description: String { get }
    var level: Float { get }
    var roundedLevel: String { get }
    
    init(description: String, level: Float)
}
