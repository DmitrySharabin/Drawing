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

struct ColorCyclingRectangle: View {
    let steps = 100
    var startPoint = UnitPoint(x: 0.5, y: 0.0)
    var endPoint = UnitPoint(x: 0.5, y: 1.0)
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: startPoint,
                            endPoint: endPoint
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps)
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var thickness = 5.0
    
    @State private var startPointX = 0.5
    @State private var startPointY = 0.0
    @State private var endPointX = 0.5
    @State private var endPointY = 1.0
    
    let range = 0.0...20.0
    let step = 5.0
    
    var body: some View {
        VStack {
            Group {
                Text("Arrow Shape")
                    .font(.title2.bold())
                
                Arrow()
                    .fill(.yellow)
                    .overlay(
                        Arrow()
                            .stroke(.black, style: StrokeStyle(lineWidth: thickness, lineJoin: .round))
                    )
                    .frame(width: 170, height: 170)
                    .onTapGesture {
                        withAnimation {
                            thickness = Double.random(in: range)
                        }
                    }
                
                Stepper("Line thickness: \(thickness.formatted())", value: $thickness.animation(), in: range, step: step)
                    .padding(.vertical)
            }
            
            Divider()
            
            Group {
                Text("ColorCyclingRectangle Shape")
                    .font(.title2.bold())
                
                ColorCyclingRectangle(
                    startPoint: UnitPoint(x: startPointX, y: startPointY),
                    endPoint: UnitPoint(x: endPointX, y: endPointY)
                )
                    .frame(width: 350, height: 220)

                VStack {
                    Text("Linear Gradient")
                        .font(.title3)
                        .padding(.top, 10)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("Start point")
                                .font(.headline)
                            
                            HStack {
                                Text("X")
                                Slider(value: $startPointX)
                            }
                            
                            HStack {
                                Text("Y")
                                Slider(value: $startPointY)
                            }
                        }
                        
                        VStack {
                            Text("End point")
                                .font(.headline)
                            
                            HStack {
                                Text("X")
                                Slider(value: $endPointX)
                            }
                            
                            HStack {
                                Text("Y")
                                Slider(value: $endPointY)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
