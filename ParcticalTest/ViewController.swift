//
//  ViewController.swift
//  ParcticalTest
//
//  Created by Zarna M. Patel on 04/09/17.
//  Copyright © 2017 Zarna M. Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Mark :- Variable declaration
    var collectionView: UICollectionView?
    var number: [String] = []
    var uniqueNumber = [String]()
    let defaults = UserDefaults.standard
    
    // Mark :- Outlets
    @IBOutlet weak var flowLayoutOutlet: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var txtResult: UITextField!
    @IBOutlet weak var findResult: UIButton!
    @IBOutlet weak var countUniqueNumber: UIBarButtonItem!
    @IBOutlet weak var findRandomValue: UIButton!
    
    // Mark :- View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cellSize(view.frame.size, itemCount: 4)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blur5.jpg")!)
        self.collectionViewOutlet.backgroundColor = UIColor.clear
        self.txtResult.backgroundColor = UIColor.clear
        findResult.isEnabled = false
        countUniqueNumber.isEnabled = false
        findRandomValue.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        animateButton()
    }
    
    // Mark :- Button action
    // Random Value button
    @IBAction func findRandomValue(_ sender: UIButton) {
        for _ in 0 ..< 16 {
            let randomNumber = arc4random() % 10
            number.append(String(randomNumber))
        }
        collectionViewOutlet.reloadData()
        findResult.isEnabled = true
        countUniqueNumber.isEnabled = true
    }
    // Unique number button
    @IBAction func countUniqueNumber(_ sender: UIBarButtonItem) {
        uniqueNumber.removeAll()
        for i in 0 ... 9 {
            var count = 0
            for j in 0 ..< number.count {
                let num = Int(number[j])
                if i == num {
                    count = count + 1
                }
            }
            if count != 0 {
                //print("count of \(i) is \(count)")
                uniqueNumber.append("count of \(i) is \(count)")
            }
        }
        if uniqueNumber.count == 0 {
            let alert = UIAlertController.init(title: "Number Not Found", message: "Press Random Value button", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
            let nxt = storyboard?.instantiateViewController(withIdentifier: "UniqueNumberVC") as! UniqueNumberVC
            defaults.removeObject(forKey: "uniqueNum")
            defaults.set(uniqueNumber, forKey: "uniqueNum")
            print(uniqueNumber)
            //nxt.uNumber = uniqueNumber
            self.navigationController?.pushViewController(nxt, animated: true)
        }
    }
    // Sum button
    @IBAction func findResult(_ sender: UIButton) {
        var count :Int = 0
        if txtResult.text == "" {
            let alert = UIAlertController.init(title: "Enter Number", message: "Number Not Entered", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
            let input = Int(txtResult.text!)
            var firstIndex:Int? = nil
            for j in 0 ..< number.count {
                let num = Int(number[j])
                if input == num {
                    if firstIndex == nil {
                        firstIndex = j
                    }
                    count = count + input!
                }
            }
            for j in 0 ..< number.count {
                if firstIndex == j{
                    number[j] = String(count)
                } else {
                    number[j] = String(" ")!
                }
            }
            collectionViewOutlet.reloadData()
        }
    }
    // Clear button
    @IBAction func clearRandomValue(_ sender: UIBarButtonItem) {
        number.removeAll()
        txtResult.text = ""
        findResult.isEnabled = false
        countUniqueNumber.isEnabled = false
        collectionViewOutlet.reloadData()
    }
    
    func animateButton() {
        findResult.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 4.0,delay: 0,usingSpringWithDamping: 0.2,initialSpringVelocity: 6.0,options: .allowUserInteraction,animations: { [weak self] in
            self?.findRandomValue.transform = .identity
            self?.findResult.transform = .identity
        },completion: nil)
    }
}

// Mark :- CollectionView Extention
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.number.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 0.5
        cell.textLabel.text = String(number[indexPath.row])
        return cell
    }
    
    func cellSize(_ size: CGSize, itemCount: Int) {
        let cvFlowLayout = flowLayoutOutlet!
        let cvSize = size
        var cellSize = CGSize()
        let minimumInteritemSpacingMultiplier:CGFloat = CGFloat(itemCount - 1)
        cellSize.width = (cvSize.width - (cvFlowLayout.minimumInteritemSpacing * minimumInteritemSpacingMultiplier + cvFlowLayout.sectionInset.left + cvFlowLayout.sectionInset.right )) / CGFloat(itemCount)
        cellSize.height = cellSize.width
        cvFlowLayout.itemSize = cellSize
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        cellSize(size, itemCount: 4)
    }
}
