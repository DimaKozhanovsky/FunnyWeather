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
    //  тут мы описваемм  2 дженрика Placeholder и ProgressBlock и подрисываем их на проткол вью чтобы  можно было засунуть все, что конформит протокол View для реюзабельности
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    //@Environment нужно чтобы понимать настройки юзера и под них адаптировать кожд
    // In SwiftUI, we can switch between a HStack and VStack based on the horizontalSizeClass that we get from the @Environment:
    @StateObject var viewModel: ImageViewModel
    
    let placeholder: Placeholder
    let progressBlock: ProgressBlock
    // в константы выше можно ложить все что подписано на протокол View
    
    init(
        //In Swift, an initializer is a special function that we use to create objects of a particular class, struct, or enum. Initializers are sometimes called constructors because they "construct" objects.
        imageUrlString: String,
        //
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
