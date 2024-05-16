//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Igor Florentino on 14/05/24.
//

import SwiftUI

struct AddressView: View {
	@Bindable var order: Order
	
    var body: some View {
		NavigationStack{
			Form{
				Section{
					TextField("name", text: $order.name)
					TextField("street address", text: $order.streetAddress)
					TextField("city", text: $order.city)
					TextField("zip", text: $order.zip)
				}
				Section{
					NavigationLink("Checkout"){
						CheckoutView(order: order)
					}
				}.disabled(order.hasValidAddress == false)
			}
			.navigationTitle("Delivery details")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

#Preview {
	AddressView(order: Order())
}
