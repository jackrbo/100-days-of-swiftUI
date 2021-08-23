//
//  ContentView.swift
//  Animations
//
//  Created by Richard-Bollans, Jack on 21.8.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var enabled = false
    let letters = Array("Hello SwiftUI")
    @State private var isShowingRed = false
    
    @State private var dragAmount = CGSize.zero

    var body: some View {
//        print(animationAmount)
//
//        return VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(
//                Animation.easeInOut(duration: 1)
//                    .repeatCount(3, autoreverses: true)
//            ), in: 1...10)
//            Spacer()
//
//            Button("Tap"){
//                withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
//                    angle += 2 * Double.pi
//                }
//
//
//            }
//            .padding(40)
//            .foregroundColor(.white)
//            .background(Color.red)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//            .rotation3DEffect(
//                Angle(radians: angle),
//                axis: (x: 0, y: 0, z: 1
//
//                )
//            )
        
        
//        Button("Tap Me") {
//            self.enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? Color.blue : Color.red)
//        .animation(nil)
//        .foregroundColor(.white)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
        VStack {
            Button("Tap Me") {
                withAnimation(.easeIn(duration: 2)) {
                    self.isShowingRed.toggle()
                }
            }
            
//            HStack(spacing: 0) {
//                ForEach(0..<letters.count) { num in
//                    Text(String(self.letters[num]))
//                        .padding(5)
//                        .font(.title)
//                        .background(enabled ? Color.blue : Color.red)
//                        .offset(self.dragAmount)
//                        .animation(Animation.default.delay(Double(num) / 20))
//                }
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged{ dragAmount = $0.translation }
//                    .onEnded{ _ in
//                        withAnimation(.spring()) {
//                            dragAmount = CGSize.zero
//                            enabled.toggle()
//                    }
//                }
//            )
            
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot.animation(.easeIn(duration: 1)))
            }
        }
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .animation(.spring())
//            .gesture(
//                DragGesture()
//                    .onChanged{ dragAmount = $0.translation }
//                    .onEnded{ _ in
//                        withAnimation(.spring()) {
//                            dragAmount = CGSize.zero
//
//                    }
//                }
//            )
    }
        
        
 
  
        
}
    
    
struct CornerRotationModifier: ViewModifier {
    
    
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotationModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotationModifier(amount: 0, anchor: .topLeading)
        )
    }
}
