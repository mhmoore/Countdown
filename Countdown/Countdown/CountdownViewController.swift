//
//  CountdownViewController.swift
//  Countdown
//
//  Created by Michael Moore on 1/26/22.
//

import UIKit

class CountdownViewController: UIViewController {
    @IBOutlet private weak var longevityNumberLabel: UILabel!
    @IBOutlet private weak var lifeProgressView: UIProgressView!
    @IBOutlet private weak var birthDateStackView: UIStackView!
    @IBOutlet private weak var birthDateTextField: UITextField!
    @IBOutlet private weak var countdownContainerView: UIView!
    @IBOutlet private weak var yearsNumberLabel: UILabel!
    @IBOutlet private weak var monthsNumberLabel: UILabel!
    @IBOutlet private weak var weeksNumberLabel: UILabel!
    @IBOutlet private weak var daysNumberLabel: UILabel!
    @IBOutlet private weak var hoursNumberLabel: UILabel!
    @IBOutlet private weak var minutesNumberLabel: UILabel!
    @IBOutlet private weak var secondsNumberLabel: UILabel!
    @IBOutlet private weak var sliderStackView: UIStackView!
    @IBOutlet private weak var longevitySlider: UISlider!
    @IBOutlet private weak var longevitySliderNumberLabel: UILabel!
    @IBOutlet private weak var calculateResetButton: UIButton!
    
    private var isCalculated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateResetButton.setTitle("Calculate!", for: .normal)
        calculateResetButton.layer.cornerRadius = 8
        birthDateStackView.isHidden = false
        sliderStackView.isHidden = false
        countdownContainerView.isHidden = true
        longevitySlider.minimumValue = 0
        longevitySlider.maximumValue = 123
        longevitySlider.value = 75
        longevityNumberLabel.text = "75"
        longevitySliderNumberLabel.text = "75"
        lifeProgressView.progress = 0.75
        
    }
    
    @IBAction func longevitySliderChangedValue(_ sender: Any) {
        longevitySliderNumberLabel.text = "\(Int(longevitySlider.value))"
    }
    
    @IBAction func calculateResetButtonTapped(_ sender: Any) {
        if isCalculated == false {
            isCalculated.toggle()
            calculateResetButton.setTitle("Reset", for: .normal)
            birthDateStackView.isHidden = true
            sliderStackView.isHidden = true
            countdownContainerView.isHidden = false
            
            longevityNumberLabel.text = "\(Int(longevitySlider.value))"
        } else {
            isCalculated.toggle()
            calculateResetButton.setTitle("Calculate!", for: .normal)
            birthDateStackView.isHidden = false
            sliderStackView.isHidden = false
            countdownContainerView.isHidden = true
        }
    }
    
    func avenirFont(size: CGFloat) -> UIFont {
        guard let avenirFont = UIFont(name: "AvenirNext-DemiBold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return avenirFont
    }
}

