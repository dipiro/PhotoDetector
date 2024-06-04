//
//  ContentView.swift
//  PhotoDetector
//
//  Created by piro2 on 6/1/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack {
            if let image = viewModel.image {
                preview(for: image)
                CList(items: viewModel.results, label: createCell)
                    .frame(height: Const.listHeigh)
            }
            Spacer()
            HStack(spacing: Const.buttonSpacing) {
                cameraButton
                galleryButton
            }
            .padding(.bottom)
        }
        .sheet(isPresented: $viewModel.isShowingCamera) {
            CameraViewRepresentable(image: $viewModel.image)
                .ignoresSafeArea(edges: .bottom)
        }
    }
}

// MARK: - Private
private extension ContentView {
    var cameraButton: some View {
        Button { viewModel.isShowingCamera.toggle() } label: {
            createTitleButton("Open Camera")
        }
    }
    
    var galleryButton: some View {
        PhotosPicker(selection: $viewModel.photoItem, matching: .images) {
            createTitleButton("Open Gallery")
        }
    }
    
    func preview(for image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: Const.imageCornerRadius))
            .padding()

    }
    
    func createTitleButton(_ text: String) -> some View {
        Text(text)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(Const.textCornerRadius)
    }
    
    func createCell(_ item: PhotoDetectingModel) -> some View {
        Text("\(item.roundedLevel) \(item.description)")
    }
}

// MARK: - Const
fileprivate struct Const {
    static let imageCornerRadius: CGFloat = 10
    static let textCornerRadius: CGFloat = 10
    static let buttonSpacing: CGFloat = 16
    static let listHeigh: CGFloat = 300
}

// MARK: - Preview
#Preview {
    ContentView()
}







//struct AuthorizationChecker {
//    static func checkCaptureAuthorizationStatus() async -> Status {
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//        case .authorized:
//            return .permitted
//
//        case .notDetermined:
//            let isPermissionGranted = await AVCaptureDevice.requestAccess(for: .video)
//            if isPermissionGranted {
//                return .permitted
//            } else {
//                fallthrough
//            }
//
//        case .denied:
//            fallthrough
//
//        case .restricted:
//            fallthrough
//
//        @unknown default:
//            return .notPermitted
//        }
//    }
//}
//
//extension AuthorizationChecker {
//    enum Status {
//        case permitted
//        case notPermitted
//    }
//}
