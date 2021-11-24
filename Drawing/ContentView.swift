//
//  ContentView.swift
//  Drawing
//
//  Created by Dmitry Sharabin on 17.11.2021.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.height * 0.2),
            control1: CGPoint(x: rect.width * 0.1, y: rect.midY),
            control2: CGPoint(x: rect.width * 0.1, y: rect.height * 0.3)
        )
        
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height * 0.1))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.height * 0.3))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.height * 0.4))
        
        path.addCurve(
            to: CGPoint(x: rect.width * 0.2, y: rect.height * 0.9),
            control1: CGPoint(x: rect.width / 4, y: rect.height * 0.4),
            control2: CGPoint(x: rect.width / 4, y: rect.midY)
        )
        path.closeSubpath()
        
        return path
    }
}

struct ContentView: View {
    @State private var thickness = 5.0
    
    let range = 0.0...20.0
    let step = 5.0
    
    var body: some View {
        VStack {
            Arrow()
                .fill(.yellow)
                .overlay(
                    Arrow()
                        .stroke(.black, style: StrokeStyle(lineWidth: thickness, lineJoin: .round))
                )
                .frame(width: 300, height: 300)
                .onTapGesture {
                    withAnimation {
                        thickness = Double.random(in: range)
                    }
            }
            
            Stepper("Line thickness: \(thickness.formatted())", value: $thickness.animation(), in: range, step: step)
                .padding(.vertical)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
