//
//  NetworkImageView.swift
//  WeatherApp
//
//

import SwiftUI
import UIKit
import Combine

struct NetworkImageView<Placeholder: View, ProgressBlock: View>: View {
    // Here we describe 2 generics Placeholder and ProgressBlock and subscribe them to the view protocol so that we can put everything that conforms to the View protocol for reusability
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    //@Environment It is needed to understand the user settings and adapt the code to them
    // In SwiftUI, we can switch between a HStack and VStack based on the horizontalSizeClass that we get from the @Environment:
    @StateObject var viewModel: ImageViewModel
    //@StateObject makes sure that only one instance is created per a view structure. This enables us to use @StateObject property wrappers for class type view models which eliminates the need of managing the view model’s lifecycle ourselves.
    

    
    let placeholder: Placeholder
    let progressBlock: ProgressBlock
    //In the constants above, you can put everything that is subscribed to the View protocol
    
    init(
        //In Swift, an initializer is a special function that we use to create objects of a particular class, struct, or enum. Initializers are sometimes called constructors because they "construct" objects.
        imageUrlString: String,
        
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder progressBlock: () -> ProgressBlock
    ) {
        
        _viewModel = .init(wrappedValue: ImageViewModel(imageUrlString: imageUrlString))
            //_viewModel
       // designate private variables , a view model is created, and the view subscribes to its changes,
                 // this is how you initialize @StateObject, this is its initializer, look towards @properyWrapper, how it works
    
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
