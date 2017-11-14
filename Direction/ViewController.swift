//
//  ViewController.swift
//
//  Created by Andrew Halls on 13/11/17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var directionPickerView: UIPickerView!
    @IBOutlet weak var directionDescriptionLabel: UILabel!
    
    var directionPickerViewManager : DirectionPickerViewManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        directionPickerViewManager = DirectionPickerViewManager(directionPickerView!)
            { (direction) in
                self.updateDirectionDescritionLabel(direction)
            }
    }

    func updateDirectionDescritionLabel(_ direction: Direction) {
           self.directionDescriptionLabel.text = direction.description
    }
}

class DirectionPickerViewManager: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerList = Direction.allValues
    
    let pickerDidChangeDirection: ((Direction) -> Void)?
    
    init (_ pickerView: UIPickerView, _ defaultDirection: Direction = .south,  pickerDidChangeDirection: ((Direction) -> Void)? = nil) {
        
        self.pickerDidChangeDirection = pickerDidChangeDirection
        
        super.init()
        
        pickerView.delegate = self
        pickerView.dataSource = self
      
        let defaultRow = rowForDirection(defaultDirection)
        pickerView.selectRow( defaultRow, inComponent: 0, animated: true)
        self.pickerView(pickerView, didSelectRow: defaultRow,  inComponent: 0)
        
    }
    
    func rowForDirection(_ direction: Direction) -> Int {
        return pickerList.index(of: direction) ?? 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickerDidChangeDirection = pickerDidChangeDirection  {
            pickerDidChangeDirection(pickerList[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row].caseName.capitalized
    }


    
}
