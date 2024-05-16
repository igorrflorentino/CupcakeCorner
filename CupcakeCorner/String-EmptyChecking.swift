//
//  String-EmptyChecking.swift
//  CupcakeCorner
//
//  Created by Igor Florentino on 16/05/24.
//

import Foundation

extension String {
	var isReallyEmpty: Bool{
		self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
	}
}
