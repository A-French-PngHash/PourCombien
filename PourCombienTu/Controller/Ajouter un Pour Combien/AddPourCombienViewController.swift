////This file was created on 21/11/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class AddPourCombienViewController: UIViewController {

	@IBAction func crossButtonPressed(_ sender: Any) {
		storeRamData.shared.pourCombienAdd = pourCombienText.text
		dismiss(animated: true, completion: nil)
	}
	@IBOutlet weak var pourCombienText: UITextView!
	@IBOutlet weak var selectCategoryTableView: UITableView!
	@IBAction func touchScreen(_ sender: Any) {
		pourCombienText.resignFirstResponder()
	}

	@IBAction func addButtonPressed(_ sender: Any) {
		let selectedCategory = tableViewDelegate!.selectedCategory
		ManageData.shared.addPourcombien(pourCombienPhrase: pourCombienText.text, categoriesPourCombien: selectedCategory)
		dismiss(animated: true, completion: nil)
		storeRamData.shared.pourCombienAdd = "Pour combien tu..."
	}

	var tableViewDelegate : SelectCategoryTableViewAdd?
    override func viewDidLoad() {
        super.viewDidLoad()
		pourCombienText.text = storeRamData.shared.pourCombienAdd
		tableViewDelegate = SelectCategoryTableViewAdd()
		selectCategoryTableView.delegate = tableViewDelegate
		selectCategoryTableView.dataSource = tableViewDelegate
    }
}

extension AddPourCombienViewController : UITextViewDelegate {
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

		if text == "\n" {
			textView.resignFirstResponder()
			return false
		}
		return true
	}
}
