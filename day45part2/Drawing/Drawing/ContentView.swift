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

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.move(to: CGPoint(x: 0, y: rect.maxY))

        return path

    }
    
    var insetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
}


struct CheckerBoard: Shape {
    var rows: Int
    var columns: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        
        let columnSize = rect.width / CGFloat(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2){
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
    
    public var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(Double(rows), Double(columns))}
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }

}
struct ContentView: View {

    @State private var rows = 4
    @State private var columns = 4

    private let blendMode :BlendMode = .screen
    var body: some View {
//        Testing with anders picture
//        ZStack {
//            Image("anders")
//
//            Rectangle()
//                .fill(Color.red)
////
//                .blendMode(.screen)
//                .blendMode(.multiply)
//        }
//        .frame(width: 400, height: 500)
//        .clipped()
        
//        Playing with blendModes
        
//        VStack {
//            ZStack {
//                Circle()
//                    .fill(Color.red)
//                    .frame(width:200 * amount)
//                    .offset(x: -50, y: -180)
//                    .blendMode(blendMode)
//
//                Circle()
//                    .fill(Color.green)
//                    .frame(width:200 * amount)
//                    .offset(x: 50, y: -180)
//                    .blendMode(blendMode)
//
//
//                Circle()
//                    .fill(Color.blue)
//                    .frame(width:200 * amount)
//                    .offset(x: 0, y: -100)
//                    .blendMode(blendMode)
//
//                Image("anders")
//                    .resizable()
//                        .scaledToFit()
//                        .frame(width: 200, height: 200)
//                        .saturation(Double(amount))
//                        .blur(radius: (1 - amount) * 20)
//
//            }
//            .frame(width: 300, height: 300)
//
//            Slider(value: $amount)
//                .padding()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.black)
//                .edgesIgnoringSafeArea(.all)
        
        
//        ANIMATIONS
        CheckerBoard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
