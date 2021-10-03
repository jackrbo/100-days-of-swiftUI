//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Richard-Bollans, Jack on 28.9.2021.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var model = OrderModel()
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $model.order.type) {
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $model.order.quantity, in: 3...20){
                        Text("Number of cakes: \(model.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $model.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if model.order.specialRequestEnabled {
                        Toggle(isOn: $model.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $model.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink("Delivery details", destination: AddressView(model: model))
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
