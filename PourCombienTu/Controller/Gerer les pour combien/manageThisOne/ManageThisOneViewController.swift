////This file was created on 01/12/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class ManageThisOneViewController: UIViewController {
	//MARK: - Properties and Outlets
	@IBOutlet weak var textViewPourCombien: UITextView!
	@IBOutlet weak var tableView: UITableView!
	var categories : Array<String>!
	var pourCombien : String!
	var tableViewDelegate : SelectCategoryTableViewManage!

	//MARK: - IBAction
	@IBAction func menuButtonPressed(_ sender: Any) {
		save()
	} 
	@IBAction func crossButtonPressed(_ sender: Any) {
		save()
		self.dismiss(animated: true, completion: nil)
	}
	//MARK: - View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
		tableViewDelegate = SelectCategoryTableViewManage()
		tableView.delegate = tableViewDelegate
		tableView.dataSource = tableViewDelegate
		tableViewDelegate.selectedCategory = categories
		textViewPourCombien.text = pourCombien

    }

	private func save() {
		ManageData.shared.removePourCombien(pourCombienPhrase: pourCombien)
		ManageData.shared.addPourcombien(pourCombienPhrase: textViewPourCombien.text, categoriesPourCombien: tableViewDelegate.selectedCategory)
	}
}
