//
//  FirstVC.swift
//  ChangeBG
//
//  Created by Alexandr Filovets on 6.09.23.
//

import UIKit

class FirstVC: UIViewController, ColorDelegate {
    func didSelectColor(_ color: UIColor) { view.backgroundColor = color }
    
    @IBAction func goToSecondVC() {
        let stor = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = stor.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC else { return }
        
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
