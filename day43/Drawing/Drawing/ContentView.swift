//
//  ContentView.swift
//  Drawing
//
//  Created by Richard-Bollans, Jack on 14.9.2021.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Arc: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    var startAngle: Angle
    var endAngle: Angle
    var clockWise: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: startAngle - .degrees(90), endAngle: endAngle - .degrees(90), clockwise: !clockWise)
        
        return path
    }
    
    
}

struct Flower: Shape {
    
   
    
    var petalOffset: Double = -20
    
    var petalWidth: Double = 100
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: CGFloat.pi * 2 , by: .pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2 , y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))

            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
    
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
//                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {

    @State private var petalOffset: Double = -20
    @State private var petalWidth = 100.0
    @State private var colorCycle = 0.0
    var body: some View {
        VStack {
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .fill(Color.red, style: FillStyle(eoFill: true))
//                .frame(width: 300, height:100, alignment: .center)
//
//            Text("Offest")
//
//
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//            Text("Width")
//                .frame(width: 300, height:300, alignment: .center)
//                .border(ImagePaint(image: Image("anders"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 0.5), scale: 0.2), width: 30)
//
//            Capsule()
//                .strokeBorder(ImagePaint(image: Image("anders"), scale: 0.1), lineWidth: 20)
//                .frame(width: 300, height: 200)
//
//
//            Slider(value: $petalWidth, in: -40...200)
//                .padding([.horizontal, .bottom])
            
            
            ColorCyclingCircle(amount: self.colorCycle)
                            .frame(width: 300, height: 300)
            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
