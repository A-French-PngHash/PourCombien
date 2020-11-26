////This file was created on 20/11/2019 by Titouan Blossier. Do not reproduce without permission.
import CoreData
import Foundation

class ManageData {
	static var shared = ManageData()
	private init() {}

	public func getPourCombienAsCoreDataObject() -> Array<PourCombien>{
		let request : NSFetchRequest<PourCombien> = PourCombien.fetchRequest()
		guard let pourCombien = try? AppDelegate.viewContext.fetch(request) else {
			return []
		}
		return pourCombien
	}

	public func getPourCombienAsString() -> Array<String> {
		let pourCombien = getPourCombienAsCoreDataObject()
		var returnArray : Array<String> = []
		for i in pourCombien {
			returnArray.append(i.pourCombien!)
		}
		return returnArray
	}

	public func getCategoriesAsCoreDataObject() -> Array<Categories> {
		let request : NSFetchRequest<Categories> = Categories.fetchRequest()
		guard let categories = try? AppDelegate.viewContext.fetch(request) else {
			return []
		}
		return categories
	}

	public func getCategoriesAsString() -> Array<String> {
		let categories = getCategoriesAsCoreDataObject()
		var returnArray = [String]()
		for i in categories {
			returnArray.append(i.name!)
		}
		return returnArray
	}

	public func addCategorie(name : String) {
		let categorie = Categories(context: AppDelegate.viewContext)
		categorie.name = name
		try? AppDelegate.viewContext.save()
	}

	public func addPourcombien(pourCombienPhrase : String, categoriesPourCombien : Array<String>){

		let pourCombien = PourCombien(context: AppDelegate.viewContext)
		pourCombien.pourCombien = pourCombienPhrase
		let categories = getCategoriesAsCoreDataObject()

		var categoriesOfThisOne : Array<Categories> = []
		if categoriesPourCombien.count > 0 {
			for a in 0...categoriesPourCombien.count - 1{ //Trouve les categories de ce pour combien dans celle contenue dans Core Data pour les lui attribuer.
				for b in categories{
					if b.name == categoriesPourCombien[a] {
						categoriesOfThisOne.append(b)
					}
				}
				pourCombien.categories = NSSet(array: categoriesOfThisOne)
				try? AppDelegate.viewContext.save()
			}
		} else {
			try? AppDelegate.viewContext.save()
		}
	}

	public func removePourCombien(pourCombienPhrase : String) {
		let request : NSFetchRequest<PourCombien> = PourCombien.fetchRequest()
		guard let pourCombien = try? AppDelegate.viewContext.fetch(request) else {
			return
		}
		for i in pourCombien{
			if i.pourCombien == pourCombienPhrase {
				AppDelegate.viewContext.delete(i)
				try? AppDelegate.viewContext.save()
				return
			}
		}
	}

	public func removeCategories(category : String) {
		let categories = getCategoriesAsCoreDataObject()
		for i in categories {
			if i.name == category {
				AppDelegate.viewContext.delete(i)
				try? AppDelegate.viewContext.save()
				return
			}
		}
	}

	public func getCategoriesFor(pourCombien : PourCombien) -> Array<String> {
		let allCategories = getCategoriesAsCoreDataObject()
		var returnArray : Array<String> = []
		for i in pourCombien.categories!{
			for c in allCategories {
				if i as! Categories == c {
					returnArray.append(c.name!)
					break
				}
			}
		}
		return returnArray
	}

	public func set(pourCombien : String, categories : Array<String>){
		/*STEPS :
			- Remove ancient pour combien
			- Create new one
			- Find all categories as core data object
			- Add categories to the new one
		*/

		removePourCombien(pourCombienPhrase: pourCombien)
		self.addPourcombien(pourCombienPhrase: pourCombien, categoriesPourCombien: categories)

	}
}
