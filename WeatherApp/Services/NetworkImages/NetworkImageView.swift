//
//  NetworkImageView.swift
//  WeatherApp
//
//  Created by Dima Kozhanovsky on 09/04/2023.
//

import SwiftUI
import UIKit
import Combine

struct NetworkImageView<Placeholder: View, ProgressBlock: View>: View {
    
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
//struct NetworkImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        NetworkImageView()
//    }
//}
