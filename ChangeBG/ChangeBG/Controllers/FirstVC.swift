//
//  FirstVC.swift
//  ChangeBG
//
//  Created by Alexandr Filovets on 6.09.23.
//

import UIKit

protocol ColorUpdateProtocol { func setBackgroundColor(_ color: UIColor) }

class FirstVC: UIViewController {
    // Делегирование
    var backgroundColor: UIColor?
    // Замыкание
    var colorClosure: ((UIColor) -> Void)?

    @IBAction func goToSecondVC() {
        let stor = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = stor.instantiateViewController(withIdentifier: "SecondVC") as? SecondVC else { return }
        // Делегирование
        secondVC.view.backgroundColor = view.backgroundColor
        secondVC.delegate = self
        // Замыкание
        secondVC.colorClosure = { [weak self] color in
            self?.view.backgroundColor = color
        }
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

extension FirstVC: ColorUpdateProtocol { func setBackgroundColor(_ color: UIColor) { view.backgroundColor = color } }
