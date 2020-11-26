////This file was created on 21/11/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class ManageCategoryViewController: UIViewController {

	//MARK: - Validation
	@IBAction func okButtonPressed(_ sender: Any) {
		add()
	}

	//MARK: - Outlets and properties
	@IBAction func tapOnScreen(_ sender: Any) {
		categoryLabel.resignFirstResponder()
	}
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var categoryLabel: UITextField!
	@IBAction func menuButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	var categories : Array<String>!
    override func viewDidLoad() {
        super.viewDidLoad()
		categories = ManageData.shared.getCategoriesAsString()
        // Do any additional setup after loading the view.
    }

	func add() {
		print("adding")
		//Need to check if not nil
		//Need to check if category is not already existing
		//Need to add category
		if let texte = categoryLabel.text{
			if texte != "" {
				for i in categories {
					if i == texte {
						let alert = UIAlertController(title: "Erreur", message: "Cette catégorie existe déjà...", preferredStyle: .alert)
						alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
						self.present(alert, animated: true, completion: nil)
						return
					}
				}
				ManageData.shared.addCategorie(name: texte)
				categories = ManageData.shared.getCategoriesAsString()
				tableView.reloadData()
				categoryLabel.resignFirstResponder()
				categoryLabel.text! = ""
				let alert = UIAlertController(title: "Succes", message: "La catégorie à bien été ajoutée", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
				self.present(alert, animated: true, completion: nil)
				return
			}
		}
		let alert = UIAlertController(title: "Erreur", message: "Veuillez renseigner un nom pour la catégorie", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}

//MARK: - Table View Delegate
extension ManageCategoryViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
		cell.textLabel?.text = categories[indexPath.row]
		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let name = tableView.cellForRow(at: indexPath)!.textLabel!.text!

			let alert = UIAlertController(title: "Suprimer une catégorie", message: "Etes vous sur de vouloir suprimer la catégorie \(name) ? Cette opération est irréversible.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Oui", style: .destructive, handler: {action in
				ManageData.shared.removeCategories(category: name)
				self.categories = ManageData.shared.getCategoriesAsString()
				tableView.reloadData()
			}))

			alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}
}

extension ManageCategoryViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		add()
		return true
	}
}
