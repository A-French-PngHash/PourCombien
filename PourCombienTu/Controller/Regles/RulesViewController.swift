////This file was created on 01/12/2019 by Titouan Blossier. Do not reproduce without permission.

import UIKit

class RulesViewController: UIViewController {

	@IBOutlet weak var rulesLabel: UILabel!
	@IBAction func menuButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	override func viewDidLoad() {
        super.viewDidLoad()
		rulesLabel.adjustsFontForContentSizeCategory = false
    }
}
