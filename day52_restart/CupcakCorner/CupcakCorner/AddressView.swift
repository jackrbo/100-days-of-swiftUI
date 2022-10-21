//
//  AddressView.swift
//  CupcakCorner
//
//  Created by Richard-Bollans, Jack on 7.10.2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderClass: OrderClass
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderClass.order.name)
                TextField("Street Address", text: $orderClass.order.streetAddress)
                TextField("City", text: $orderClass.order.city)
                TextField("Zip", text: $orderClass.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderClass: orderClass)
                } label: {
                    Text("Check out")
                }
                
            }
            .disabled(!orderClass.order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orderClass: OrderClass())
        }
    }
}
