////This file was created on 21/11/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class ManagePourCombienViewController: UIViewController {
	//Mark: - IBaction
	@IBAction func menuButtonPressed(_ sender: Any) {
		storeRamData.shared.searchText = searchBar.text!
		dismiss(animated: true, completion: nil)
	}
	//MARK: - Outlets and properties
	@IBOutlet weak var tableView: UITableView!

	@IBOutlet weak var searchBar: UISearchBar!
	var pourCombien : Array<PourCombien> {
		return ManageData.shared.getPourCombienAsCoreDataObject()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		searchBar.text = storeRamData.shared.searchText
		if searchBar.text != "" {
			shouldSearch = true
			search(searchText: searchBar.text!)
		}
    }
	override func viewWillAppear(_ animated: Bool) {
		shouldSearch = true
		search(searchText: searchBar.text!)
		tableView.reloadData()
	}

	var searchresult : Array<PourCombien> = []
	var shouldSearch : Bool = false
	//MARK: - Data to pass
	var categories : Array<String>!
	var pourCombienVC : String!

	private func search(searchText : String){
		if searchText != ""{
			shouldSearch = true
			let texte = searchText.lowercased().components(separatedBy: " ")
			var newText = [String]()
			for i in texte {
				if i != "" {
					newText.append(i)
				}
			}
			searchresult = searchEngine.shared.search(words: newText)
			print(searchresult)
		} else {
			shouldSearch = false
		}
		tableView.reloadData()
	}
}
//MARK: - Table View delegate
extension ManagePourCombienViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if shouldSearch {
			return searchresult.count
		} else {
			return pourCombien.count
		}
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "pourCombien")!
		if shouldSearch {
			cell.textLabel!.text = searchresult[indexPath.row].pourCombien
			categories = ManageData.shared.getCategoriesFor(pourCombien: searchresult[indexPath.row])
		} else {
			cell.textLabel!.text = pourCombien[indexPath.row].pourCombien
			categories = ManageData.shared.getCategoriesFor(pourCombien: pourCombien[indexPath.row])
		}
		print(categories)
		var detail = ""
		if categories.count > 0 {
			for i in 0...categories.count - 1 {
				if i != categories.count - 1 {
					detail = detail + categories[i] + ", "
				} else {
					detail = detail + categories[i]
				}
			}
		}
		cell.detailTextLabel!.text = detail
		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let alert = UIAlertController(title: "Supprimer", message: "Etes vous sur de vouloir supprimer ce pour combien ? Cette opération est irréversible.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Oui", style: .destructive
				, handler: {action in
					ManageData.shared.removePourCombien(pourCombienPhrase: tableView.cellForRow(at: indexPath)!.textLabel!.text!)

					tableView.reloadData()
			}))
			alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}


	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as! ManageThisOneViewController
		vc.categories = self.categories
		vc.pourCombien = self.pourCombienVC

	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		storeRamData.shared.searchText = searchBar.text!
		if shouldSearch {
			categories = ManageData.shared.getCategoriesFor(pourCombien: searchresult[indexPath.row])
			pourCombienVC = searchresult[indexPath.row].pourCombien
		} else {
			categories = ManageData.shared.getCategoriesFor(pourCombien: pourCombien[indexPath.row])
			pourCombienVC = pourCombien[indexPath.row].pourCombien
		}
		self.performSegue(withIdentifier: "segueToManageThisOne", sender: self)
	}
}

extension ManagePourCombienViewController : UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		/* How does the search work ?
		- The user type word(s), if one is a category, every pour combien with this category will be show. if there is multiple word the pour combien need to have all the category.
		- The user type word(s), if all of the words are in the "pour combien" then the "pour combien" is a result of the search.

		The two result type are combined in order to allow the user searching "pour combien sentence" or "pour combien category" with more freedom
		*/
		search(searchText: searchText)
	}
}
