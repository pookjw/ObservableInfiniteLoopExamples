//
//  ContentView.swift
//  MyApp
//
//  Created by Jinwoo Kim on 1/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MyView()
    }
}

@Observable
final class MyViewModel {
    var integer: Int = .zero
}

struct MyView: UIViewRepresentable {
    @State var viewModel: MyViewModel = .init()
    
    func makeUIView(context: Context) -> UIView {
        .init()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        print(#function)
        
        //    withoutTracking {
        let integer = viewModel.integer
        
        Task {
            viewModel.integer = integer + 1
        }
        //    }
    }
}

func withoutTracking(_ block: () -> Void) {
    let ptr = pthread_getspecific(.init(bitPattern: 0x6a))
    pthread_setspecific(.init(bitPattern: 0x6a), nil)
    block()
    pthread_setspecific(.init(bitPattern: 0x6a), ptr)
}

#Preview {
    ContentView()
}
