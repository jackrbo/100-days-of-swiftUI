//
//  ContentView.swift
//  CupcakCorner
//
//  Created by Richard-Bollans, Jack on 7.10.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderClass = OrderClass()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderClass.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(orderClass.order.quantity)", value: $orderClass.order.quantity, in:3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $orderClass.order.specialRequestEnabled.animation())
                    if orderClass.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $orderClass.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $orderClass.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(orderClass: orderClass)
                    } label: {
                         Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
