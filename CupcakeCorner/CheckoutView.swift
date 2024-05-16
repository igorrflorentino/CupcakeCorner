//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Igor Florentino on 15/05/24.
//

import SwiftUI

struct CheckoutView: View {
	var order: Order
	@State private var showConfirmation = false
	@State private var confirmationMessage = ""
	@State private var confirmationTitle = ""
	
    var body: some View {
		ScrollView{
			VStack{
				AsyncImage(
					url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
					scale: 3
				) { image in
					image.resizable().scaledToFit()
				} placeholder: {
					ProgressView()
				}
				.frame(height: 233)
				
				Text("Your total is \(order.cost, format: .currency(code: "USD"))")
					.font(.title)
				
				Button("Place Order"){
					Task{
						await placeOrder()
					}
				}
				.padding()
				
			}
		}
		.navigationTitle("Check out")
		.navigationBarTitleDisplayMode(.inline)
		.scrollBounceBehavior(.basedOnSize)
		.alert(confirmationTitle, isPresented: $showConfirmation) {
			Button("OK") { }
		} message: {
			Text(confirmationMessage)
		}
    }
	
	func placeOrder() async {
		guard let orderData = try? JSONEncoder().encode(order) else {
			print("fail to encode order!")
			return
		}
		
		let url = URL(string: "https://reqres.in/api/cupcakes")!
		
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		
		do{
			let (data, _) = try await URLSession.shared.upload(for: request, from: orderData)
			let orderConfirmation = try JSONDecoder().decode(Order.self, from: data)
			confirmationTitle = "Thank you!"
			confirmationMessage = "Your order for \(orderConfirmation.quantity)x  \(Order.allCakeTypes[orderConfirmation.cakeType].lowercased()) cupcakes is on its way!"
			showConfirmation = true
		}catch{
			confirmationTitle = "Ops!"
			confirmationMessage = "Something when wrong!\n\nError: \(error.localizedDescription)"
			showConfirmation = true
			print("Checkout failed: \(error.localizedDescription)")
			
		}
	}
}

#Preview {
    CheckoutView(order: Order())
}
