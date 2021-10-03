//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Richard-Bollans, Jack on 28.9.2021.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var model: OrderModel
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $model.order.name)
                TextField("Street Address", text: $model.order.streetAddress)
                TextField("City", text: $model.order.city)
                TextField("Zip", text: $model.order.zip)
            }
            
            
            Section {
                NavigationLink(
                    destination: CheckoutView(model: model),
                    label: {
                        Text("Checkout")
                    })
                    
            }
            .disabled(model.order.hasValidAddress == false)
            
            
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(model: OrderModel())
        }
    }
}
