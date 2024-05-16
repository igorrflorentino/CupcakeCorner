//
//  DataModel.swift
//  CupcakeCorner
//
//  Created by Igor Florentino on 14/05/24.
//

import SwiftUI

@Observable
class Order: Codable{
	
	enum CodingKeys: String, CodingKey {
		case _cakeType = "cakeType"
		case _quantity = "quantity"
		case _hasSpecialRequest = "hasSpecialRequest"
		case _extraFrosting = "extraFrosting"
		case _addSprinkles = "addSprinkles"
		case _name = "name"
		case _city = "city"
		case _streetAddress = "streetAddress"
		case _zip = "zip"
	}

	static var allCakeTypes = ["Vanilla","Strawberry","Chocolate","Rainbow"]
	var cakeType = 0
	var quantity = 3
	var hasSpecialRequest: Bool = false{
		didSet{
			if hasSpecialRequest == false {
				extraFrosting = false
				addSprinkles = false
			}
		}
	}
	var extraFrosting: Bool = false
 	var addSprinkles: Bool = false
	
	var name: String{
		didSet{
			UserDefaults.standard.set(name, forKey: "OrderName")
		}
	}
	var streetAddress: String{
		didSet{
			UserDefaults.standard.set(streetAddress, forKey: "OrderStreetAddress")
		}
	}
	var city: String{
		didSet{
			UserDefaults.standard.set(city, forKey: "OrderCity")
		}
	}
	var zip: String{
		didSet{
			UserDefaults.standard.set(zip, forKey: "OrderZip")
		}
	}
	
	var	hasValidAddress: Bool {
		!name.isReallyEmpty &&
		!streetAddress.isReallyEmpty &&
		!city.isReallyEmpty &&
		!zip.isReallyEmpty
	}
	
	var cost: Double{
		var result: Double
		result = 2 * Double(quantity)
		result += Double(cakeType)/2
		if hasSpecialRequest {
			result += Double(quantity) * (1 + 0.5)
		}
		return result
	}
	
	init(){
		name = UserDefaults.standard.string(forKey: "OrderName") ?? ""
		streetAddress = UserDefaults.standard.string(forKey: "OrderStreetAddress") ?? ""
		city = UserDefaults.standard.string(forKey: "OrderCity") ?? ""
		zip = UserDefaults.standard.string(forKey: "OrderZip") ?? ""
	}
}
