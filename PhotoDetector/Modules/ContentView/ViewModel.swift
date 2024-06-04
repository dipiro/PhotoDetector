//
//  ViewModel.swift
//  PhotoDetector
//
//  Created by piro2 on 6/2/24.
//

import Foundation
import Observation
import SwiftUI
import PhotosUI

@Observable final class ViewModel {
    typealias Output = PhotoDetectingModel
    
    // MARK: - Properties
    var results: [Output] = []
    var isShowingCamera = false
    
    var image: Image? {
        didSet { detectImage() }
    }
    var photoItem: PhotosPickerItem? {
        didSet { loadImage() }
    }
    
    // MARK: - Private Properties
    private let detectingHandler = PhotoDetectingHandler<Output>()
}

// MARK: - Private
private extension ViewModel {
    func loadImage() {
        Task {
            image = try? await photoItem?.loadTransferable(type: Image.self)
        }
    }
    
    func detectImage() {
        Task {
            await detectingHandler.detect(image: image)
            results = await detectingHandler.processResults()
        }
    }
}
