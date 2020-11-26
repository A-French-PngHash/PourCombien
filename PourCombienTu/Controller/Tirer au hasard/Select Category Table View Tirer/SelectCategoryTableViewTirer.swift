////This file was created on 30/11/2019 by Titouan Blossier. Do not reproduce without permission.
import UIKit

class SelectCategoryTableViewTirer :NSObject, UITableViewDelegate, UITableViewDataSource {
	var selectedCategory = [String]()
	var cellClass : UITableViewCell.Type!

	var category : Array<String> {
		return ManageData.shared.getCategoriesAsString()
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return category.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath) as! SelectCategoryTableViewCellTirer
		cell.texte.text = category[indexPath.row]
		if cell.state == .selected {
			cell.SelectorImage.isHidden = false
		} else {
			cell.SelectorImage.isHidden = true
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("touch begin on \(indexPath.row)")
		let cell = tableView.cellForRow(at: indexPath) as! SelectCategoryTableViewCellTirer
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

