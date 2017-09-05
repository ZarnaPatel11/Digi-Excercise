//
//  ViewController.swift
//  ParcticalTest
//
//  Created by Zarna M. Patel on 04/09/17.
//  Copyright © 2017 Zarna M. Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var number: [Int] = []
    var uniqueNumber = [String]()
    
    @IBOutlet weak var flowLayoutOutlet: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var txtResult: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellSize(view.frame.size, itemCount: 4)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blur5.jpg")!)
        self.collectionViewOutlet.backgroundColor = UIColor.clear
        self.txtResult.backgroundColor = UIColor.clear
    }
    
    @IBAction func findRandomValue(_ sender: UIButton) {
       
        let lower : UInt32 = 0
        let upper : UInt32 = 10
        for _ in 0 ..< 16 {
            let randomNumber = arc4random_uniform(upper - lower) + lower
            number.append(Int(randomNumber))
        }
        collectionViewOutlet.reloadData()
    }

    
    @IBAction func countUniqueNumber(_ sender: UIButton) {
        for i in 0 ... 9 {
            var count = 0
            for j in 0 ..< number.count {
                let num = Int(number[j])
                if i == num {
                    count = count + 1
                }
            }
            if count != 0 {
                print("count of \(i) is \(count)")
                uniqueNumber.append("count of \(i) is \(count)")
            }
        }
        let nxt = storyboard?.instantiateViewController(withIdentifier: "UniqueNumberVC") as! UniqueNumberVC
        nxt.uNumber = uniqueNumber
        self.navigationController?.pushViewController(nxt, animated: true)
        //uniqueNumber.removeAll()
    }
    
    @IBAction func findResult(_ sender: UIButton) {
        var count :Int = 0
        let input = Int(txtResult.text!)
        var firstIndex:Int? = nil
        for j in 0 ..< number.count {
            let num = Int(number[j])
            if input == num{
                if firstIndex == nil {
                    firstIndex = j
                }
                count = count + input!
            }
        }
        for j in 0 ..< number.count {
            if firstIndex == j{
                number[j] = count
            }else{
                number[j] = Int("0")!
            }
        }
        collectionViewOutlet.reloadData()
    }
    
    @IBAction func clearRandomValue(_ sender: UIBarButtonItem) {
        number.removeAll()
        collectionViewOutlet.reloadData()
    }
}

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
        cell.layer.borderWidth = 1
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
