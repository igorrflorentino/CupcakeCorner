//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Igor Florentino on 13/05/24.
//

import SwiftUI

struct ContentView: View {
	@State private var order = Order()
	
	var body: some View {
		NavigationStack{
			Form{
				Section{
					Picker("Select your cake type", selection: $order.cakeType) {
						ForEach(Order.allCakeTypes.indices, id: \.self) {
							Text(Order.allCakeTypes[$0])
						}
					}
					Stepper("Quantity: \(order.quantity)", value: $order.quantity, in: 3...20)
				}
				Section {
					Toggle("Special Request", isOn: $order.hasSpecialRequest)
					
					if order.hasSpecialRequest {
						Toggle("Extra Frosting", isOn: $order.extraFrosting)
						Toggle("Add Sprinkles", isOn: $order.addSprinkles)
					}
				}
		
				Section{
					NavigationLink("Delivery Details"){ AddressView(order: order)
					}
				}
			}
			
			
		}
		.navigationTitle("CupCake Corner")
	}
}

#Preview {
	ContentView()
}
