////This file was created on 30/11/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit

class SelectCategoryTableViewManage :NSObject, UITableViewDelegate, UITableViewDataSource {
	var firstLoad = 1
	var selectedCategory : Array<String> = []
	var category : Array<String> {
		return ManageData.shared.getCategoriesAsString()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return category.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as! SelectCategoryTableViewCellManage
		cell.texte.text = category[indexPath.row]
		if firstLoad == 1 {
			var wasNotSelected = true
			for i in selectedCategory {
				if cell.texte.text == i{
					cell.SelectorImage.isHidden = false
					cell.state = .selected
					wasNotSelected = false
					break
				}
			}
			if wasNotSelected {
				cell.state = .notSelected
				cell.SelectorImage.isHidden = true
			}
			//ATTENTION VERIFIER QUE LA LIGNE CI DESSOUS CORRESPOND BIEN A LA PREMIERE CELLULE
			if indexPath.row == category.count - 1 { //derniere cellule, le premier chargement est fini
				firstLoad = 0
			}

		} else {
			if cell.state == .selected {
				cell.SelectorImage.isHidden = false
			} else {
				cell.SelectorImage.isHidden = true
			}
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("touch begin on \(indexPath.row)")
		let cell = tableView.cellForRow(at: indexPath) as! SelectCategoryTableViewCellManage
		if cell.state == .notSelected {
			cell.state = .selected
			selectedCategory.append(cell.texte.text!)
			cell.SelectorImage.isHidden = false
			print(cell.texte.text!)
		} else {
			print(cell.texte.text!)
			cell.state = .notSelected
			for i in 0...selectedCategory.count - 1 {
				if selectedCategory[i] == cell.texte.text! {
					selectedCategory.remove(at: i)
					break
				}
			}
			cell.SelectorImage.isHidden = true
		}
		print("selected categories : \(selectedCategory)")
		tableView.reloadData()
	}
}


