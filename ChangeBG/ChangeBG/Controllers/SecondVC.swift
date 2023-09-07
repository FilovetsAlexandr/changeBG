//
//  SecondVC.swift
//  ChangeBG
//
//  Created by Alexandr Filovets on 6.09.23.
//

import UIKit

class SecondVC: UIViewController {
    
    // Делегирование
    var delegate: ColorUpdateProtocol?
    // Замыкание
    var colorClosure: ((UIColor) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        dismissKeyboard()
    }
    
    // RED
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var redTF: UITextField!
    // GREEN
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var greenTF: UITextField!
    // BLUE
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var blueTF: UITextField!
    // HEX COLOR
    @IBOutlet var hexColorTF: UITextField!
    // OPACITY
    @IBOutlet var opacitySlider: UISlider!
    @IBOutlet var opacityTF: UITextField!
    // TEST VIEW
    @IBOutlet var testView: UIView!
    
    // RED ACTION
    @IBAction private func redSliderAction(_ sender: UISlider) {
        let value = Int(sender.value * 255)
        redTF.text = String(value)
        redTF.placeholder = String(value)
        updateTestViewColor()
    }

    @IBAction private func redTFAction(_ sender: Any) {
        guard let text = redTF.text,
              let value = Int(text),
              value >= 0, value <= 255 else { return }
        redSlider.value = Float(value) / 255
        updateTestViewColor()
    }

    // GREEN ACTION
    @IBAction func greenSliderAction(_ sender: UISlider) {
        let value = Int(sender.value * 255)
        greenTF.text = String(value)
        greenTF.placeholder = String(value)
        updateTestViewColor()
    }

    @IBAction func greenTFAction(_ sender: Any) {
        guard let text = greenTF.text,
              let value = Int(text),
              value >= 0, value <= 255 else { return }
        greenSlider.value = Float(value) / 255
        updateTestViewColor()
    }
    
    // BLUE ACTION
    @IBAction func blueSliderAction(_ sender: UISlider) {
        let value = Int(sender.value * 255)
        blueTF.text = String(value)
        blueTF.placeholder = String(value)
        updateTestViewColor()
    }
    
    @IBAction func blueTFAction(_ sender: Any) {
        guard let text = blueTF.text,
              let value = Int(text),
              value >= 0, value <= 255 else { return }
        blueSlider.value = Float(value) / 255
        updateTestViewColor()
    }
    
    // HEX COLOR ACTION
    
    @IBAction func hexColorTFAction(_ sender: Any) {
        guard let text = hexColorTF.text,
              let color = UIColor(hex: text),
              let red = color.cgColor.components?[0],
              let green = color.cgColor.components?[1],
              let blue = color.cgColor.components?[2],
              let alpha = color.cgColor.components?[3] else { return }
        // Обновляем значения слайдеров
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        opacitySlider.value = Float(alpha)
        // Обновление значений текстовых полей
        redTF.text = String(Int(red * 255))
        greenTF.text = String(Int(green * 255))
        blueTF.text = String(Int(blue * 255))
        opacityTF.text = String(Int(alpha * 100))
        updateTestViewColor()
    }
    
    // OPACITY ACTION
    @IBAction func opacitySliderAction(_ sender: UISlider) {
        let value = Int(sender.value * 100)
        opacityTF.text = String(value)
        opacityTF.placeholder = String(value)
        updateTestViewColor()
    }

    @IBAction func opacityTFAction(_ sender: Any) {
        guard let text = opacityTF.text,
              let value = Int(text),
              value >= 0, value <= 100 else { return }
        opacitySlider.value = Float(value) / 100
        updateTestViewColor()
    }
    
    // BUTTONS
    @IBAction func doneWithDelegates() {
        delegate?.setBackgroundColor(testView.backgroundColor!)
        navigationController?.popViewController(animated: true)
    }

    @IBAction func doneWithClosure() {
        colorClosure?(testView.backgroundColor ?? .clear)
        navigationController?.popToRootViewController(animated: true)
    }
    
    // Обновление цвета testView и значения HEX COLOR
    func updateTestViewColor() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        let opacity = CGFloat(opacitySlider.value)
        
        testView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: opacity)
        
        let redValue = Int(redSlider.value * 255)
        let greenValue = Int(greenSlider.value * 255)
        let blueValue = Int(blueSlider.value * 255)
        let hexColor = String(format: "#%02X%02X%02X", redValue, greenValue, blueValue)
        hexColorTF.text = hexColor
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() { view.endEditing(true) }
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        let length = hexSanitized.count

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
