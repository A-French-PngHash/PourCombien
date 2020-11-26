////This file was created on 22/12/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation

class searchEngine {
	static var shared = searchEngine()
	private init() { }

	func search(words : Array<String>) -> Array<PourCombien>{
		var all = ManageData.shared.getPourCombienAsCoreDataObject()
		var returnArray : Array<PourCombien> = []
		var secondSearchData : Array<PourCombien> = [] //To reduce the number of operations. It will only filter those who were not accepted by the first search

		//Search categories
		for i in all{
			var categories = ManageData.shared.getCategoriesFor(pourCombien: i)
			var canBeAdded = true
			for b in words { //Will check in all words to see if there are all categories.
				//Lower casing list :
				categories = categories.map { $0.lowercased()}

				let predicate = NSPredicate(format: "SELF contains %@", b)
				let searchDataSource = categories.filter { predicate.evaluate(with: $0) }
				if searchDataSource.count == 0 { //The word is not a category
					canBeAdded = false //It cant be added
					break
				}
			}
			if canBeAdded {
				returnArray.append(i)
			} else {
				secondSearchData.append(i)
			}
		}

		//Search PourCombien
		for i in secondSearchData {
			let pourCombienWord = i.pourCombien!.components(separatedBy: " ")
			var canBeAdded = true
			for c in words {
				let predicate = NSPredicate(format: "SELF contains %@", c)
				let searchDataSource = pourCombienWord.filter { predicate.evaluate(with: $0) }

				if searchDataSource.count == 0 {
					canBeAdded = false
					break
				}
			}
			if canBeAdded {
				returnArray.append(i)
			}
		}
		return returnArray
	}
}
