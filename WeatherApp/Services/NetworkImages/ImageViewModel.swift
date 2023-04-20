//
//  ImageViewModel.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 20/04/2023.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class ImageViewModel: ObservableObject {
    
    enum ImageViewState {
        case loading
        case success(UIImage)
        case error
    }
    
    @Published var state: ImageViewState = .loading
    
    private var cancellables = Set<AnyCancellable>()
    
    init(imageUrlString: String) {
        getImage(urlString: imageUrlString)
    }
    
    private func getImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid image string url")
        }
        
        NetworkService.shared.getImage(url: url, headers: [:])
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    DispatchQueue.main.async {
                        self.state = .error
                    }
                }
            }, receiveValue: { [weak self] image in
                guard let self = self else {
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = image {
                        self.state = .success(image)
                    } else {
                        self.state = .error
                    }
                }
            }
            )
            .store(in: &cancellables)
    }
}


typealias Headers = [String: Any]


struct CustomImageView<Placeholder: View, ProgressBlock: View>: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel: ImageViewModel
    
    let placeholder: Placeholder
    let progressBlock: ProgressBlock
    
    init(
        imageUrlString: String,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder progressBlock: () -> ProgressBlock
    ) {
        _viewModel = .init(wrappedValue: ImageViewModel(imageUrlString: imageUrlString))
        self.placeholder = placeholder()
        self.progressBlock = progressBlock()
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                progressBlock
            case .error:
                placeholder
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
            }
        }
    }
}
func getImage(
        url: URL,
        headers: Headers
    ) -> AnyPublisher<Data, URLError> {
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest).map(\.data).eraseToAnyPublisher()
    }


