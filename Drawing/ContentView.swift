//
//  ContentView.swift
//  Drawing
//
//  Created by Dmitry Sharabin on 17.11.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Text("Hello World")
//            .frame(width: 300, height: 300)
////            .background(.red)
////            .border(.red, width: 30)
////            .background(Image("Example"))
////            .border(Image("Example"), width: 30)
////            .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
//            .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
        
        Capsule()
            .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
