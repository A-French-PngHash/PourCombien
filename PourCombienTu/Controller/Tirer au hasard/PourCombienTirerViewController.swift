////This file was created on 21/11/2019 by Titouan Blossier. Do not reproduce without permission.
import CoreData
import UIKit

class PourCombienTirerViewController: UIViewController {
	@IBOutlet weak var pourCombienLabel: UILabel!
	var categories : Array<String> = []
	var selectCategoriesAsCore : Array<Categories> = []
	var possiblePourCombien : Array<PourCombien> = []
	var pourCombien = ManageData.shared.getPourCombienAsCoreDataObject()
	var categoriesCore = ManageData.shared.getCategoriesAsCoreDataObject()

	@IBAction func backToMenu(_ sender: Any) {
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		getPossiblePourCombien()
		tirerAuHasard()
        // Do any additional setup after loading the view.
    }

	private func getPossiblePourCombien() {
		getSelectedCategoryAsCore()
		for i in pourCombien {
			var possible = true
			for select in selectCategoriesAsCore {
				var thisOneInPourCombien = false
				for pourCombienCategorie in i.categories! { //Repeat until he find the category in the Pour Combien
					if select == pourCombienCategorie as! Categories{
						thisOneInPourCombien = true
						break
					}
				}
				if thisOneInPourCombien == false {
					possible = false
					break
				}
			}
			if possible {
				possiblePourCombien.append(i)
			}
		}
	}

	private func getSelectedCategoryAsCore() {
		for i in categories {
			for c in categoriesCore {
				if i == c.name {
					selectCategoriesAsCore.append(c)
				}
			}
		}
	}

	private func tirerAuHasard() {
		let count = possiblePourCombien.count
		var random = 0
		if count == 0 {
			pourCombienLabel.text = "Aucun pour combien ne correspond a vos critères de recherches..."
			return
		} else if count > 1 { //If count == 1 then random = 0
			random = Int.random(in: 0...count)
		}
		pourCombienLabel.text = possiblePourCombien[random].pourCombien
	}
}
