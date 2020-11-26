////This file was created on 20/11/2019 by Titouan Blossier. Do not reproduce without permission.

import Foundation
import CoreData
class LoadPourCombien {

	func loadToCoreData() {
		//Loading categories
		let getData = GetCSV()
		loadcategories(getData: getData)
		loadPourCombien(getData: getData)
	}

	func loadcategories(getData : GetCSV){
		let categories = getData.getCSV(name : "categorie") //ATTENTION : Renvoie un tableau contenant un seul tableau
		for i in 0...categories[0].count - 1{
			let categorie = Categories(context: AppDelegate.viewContext)
			categorie.name = categories[0][i]
			try? AppDelegate.viewContext.save()
		}
	}


	func loadPourCombien(getData : GetCSV) {
		let request: NSFetchRequest<Categories> = Categories.fetchRequest()
		guard let categories = try? AppDelegate.viewContext.fetch(request) else {
			return
		}

		let pourCombienData = getData.getCSV(name: "pourCombien")
		for i in 0...pourCombienData.count - 2 { //Va remplir les infos necéssaires, chaque pour combien apres l'autre
			let pourCombien = PourCombien(context: AppDelegate.viewContext)
			pourCombien.pourCombien = pourCombienData[i][0]

			var categoriesOfThisOne : Array<Categories> = []
			for a in 0...pourCombienData[i].count - 1{ //Trouve les categories de ce pour combien pour les lui attribuer.
				for b in categories{
					if b.name == pourCombienData[i][a] {
						categoriesOfThisOne.append(b)
					}
				}
				pourCombien.categories = NSSet(array: categoriesOfThisOne)
				try? AppDelegate.viewContext.save()
			}
		}
	}
}
