//
//  FirstVC.swift
//  ChangeBG
//
//  Created by Alexandr Filovets on 6.09.23.
//

import UIKit


protocol SettingsDelegate { func saveBackgroundColor(_: UIColor) }

class FirstVC: UIViewController {
    @IBAction func goToSecondVC() {
        let stor = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = stor.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC else { return }
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
}
