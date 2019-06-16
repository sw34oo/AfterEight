//
//  Extension AddrecordViewController ExercisePickerView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-10-23.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

extension AddRecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == exercisePickerView {
            return 1
        } else if pickerView == weightPickerView {
            return 3
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == exercisePickerView {
            return exercises?.count ?? 0
        } else if pickerView == weightPickerView {
            return weightPickerDataSource[component].count
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == exercisePickerView {
            selectedExercise = exercises?[row]
            exerciseTextCell.exerciseTextView.text = exercises?[row].name ?? ""
            selectedExerciseName = exercises?[row].name ?? ""
            setupLastExerciseText()
            
            exerciseTextCell.moreInfoButton.isHidden = false
            pickerView.reloadAllComponents()
            
        } else if pickerView == weightPickerView {
            selectedRep = Int(weightPickerDataSource[0][pickerView.selectedRow(inComponent: 0)]) ?? 0
            selectedSet = Int(weightPickerDataSource[1][pickerView.selectedRow(inComponent: 1)]) ?? 0
            selectedWeight = Double(weightPickerDataSource[2][pickerView.selectedRow(inComponent: 2)]) ?? 0
            
            let repAttributedText = AttributedText(numberSize: 40, captionSize: 18, firstString: String(selectedRep), secondString: "rep", lineHeightMultiple: 0.75)
            let setAttributedText = AttributedText(numberSize: 40, captionSize: 18, firstString: String(selectedSet), secondString: "set", lineHeightMultiple: 0.75)
            let weightAttributedText = AttributedText(numberSize: 40, captionSize: 18, firstString: String(Int(selectedWeight)), secondString: weightUnit, lineHeightMultiple: 0.75)
            
            weightTextCell.repsTextLabel.attributedText = repAttributedText.setAttributedText()
            weightTextCell.setsTextLabel.attributedText = setAttributedText.setAttributedText()
            weightTextCell.weightTextLabel.attributedText = weightAttributedText.setAttributedText()
            
            pickerView.reloadAllComponents()
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var exerciseLabel = UILabel()
        if let view = view as? UILabel {
            exerciseLabel = view
        } else {
            exerciseLabel = UILabel()
        }
        
        var weightsLabel = UILabel()
        
        if let view = view as? UILabel {
            weightsLabel = view
        } else {
            weightsLabel = UILabel()
        }
        
        if pickerView == exercisePickerView {
            exerciseLabel.backgroundColor = UIColor.clear
            exerciseLabel.textColor = ThemeManager.currentTheme().textColor
            exerciseLabel.textAlignment = .center
            exerciseLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
            exerciseLabel.adjustsFontSizeToFitWidth = true
            exerciseLabel.text = exercises?[row].name ?? ""
            return exerciseLabel
            
        } else if pickerView == weightPickerView {
            weightsLabel.frame = CGRect(x: pickerView.frame.width/6, y: 0, width: pickerView.frame.width/6, height: 30)
            weightsLabel.backgroundColor = UIColor.clear
            weightsLabel.textColor = ThemeManager.currentTheme().textColor
            weightsLabel.textAlignment = .left
            weightsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title3)
            weightsLabel.text = weightPickerDataSource[component][row]
            
            let weight = lround(selectedWeight)
            
            if component == 0 && row == selectedRep - 1 {
                
                let noOfRep = weightPickerDataSource[0][selectedRep - 1]
                weightsLabel.text =  noOfRep + repUnit
                
            } else if component == 1 && row == selectedSet - 1 {
                let noOfSet = weightPickerDataSource[1][selectedSet - 1]
                weightsLabel.text =  noOfSet + setUnit
                
            } else if component == 2 && row == weight {
                let noOFWeight = weightPickerDataSource[2][weight]
                weightsLabel.text =  noOFWeight + weightUnit
            }
            return weightsLabel
        }
        return UIView()
    }
    
    
    
    func setupWeightPickerView() {
        let reps = Array(1...100)
        let repsArray = reps.map({ (number) -> String in
            return String(number)
        })
        
        let sets = Array(1...50)
        let setsArray = sets.map({ (number) -> String in
            return String(number)
        })
        
        let weight = Array(0...500)
        let weightArray = weight.map({ (number) -> String in
            return String(number)
        })
        weightPickerDataSource = [repsArray, setsArray, weightArray]
    }
    
}


