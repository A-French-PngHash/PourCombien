////This file was created on 16/11/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class MenuViewController: UIViewController {

	@IBAction func unwindToMenu(segue:UIStoryboardSegue) { }

	override func viewDidLoad() {
		super.viewDidLoad()
		UIApplication.shared.preferredContentSizeCategory 
		// Do any additional setup after loading the view.
		LoadIfNeeded()
		print(ManageData.shared.getCategoriesAsString())
	}

	private func LoadIfNeeded(){

		let indicator = UserDefaults.standard.object(forKey: "load") as? Int
		if indicator == nil {
			print("nil")
			loadToCoreData()
		} else {
			if indicator == 0 {
				loadToCoreData()
			} else {
				print("Already loaded into core data")
			}
		}
	}

	private func loadToCoreData() {
		let loadData = LoadPourCombien()
		loadData.loadToCoreData()
		UserDefaults.standard.set(1, forKey: "load")
	}
}
