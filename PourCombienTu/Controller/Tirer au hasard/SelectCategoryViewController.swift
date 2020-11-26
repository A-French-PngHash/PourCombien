////This file was created on 21/11/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class SelectCategoryViewController: UIViewController {
	var tableViewDelegate : SelectCategoryTableViewTirer?
	@IBOutlet weak var selectCategoryTableView: UITableView!

	@IBAction func crossButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		tableViewDelegate = SelectCategoryTableViewTirer()
		selectCategoryTableView.delegate = tableViewDelegate
		selectCategoryTableView.dataSource = tableViewDelegate
		print("view did load SelectCategory")
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "SelectToTirer" {
			let tirerVC = segue.destination as! PourCombienTirerViewController
			print("date which will be transfered : \(tableViewDelegate!.selectedCategory)")
			tirerVC.categories = tableViewDelegate!.selectedCategory
		}
	}
}
