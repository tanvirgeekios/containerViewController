//
//  ContainerViewController.swift
//  ContainerViewController
//
//  Created by MD Tanvir Alam on 23/2/21.
//

import UIKit

class ContainerViewController: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private lazy var vcA:ChildAViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(identifier: "ChildAViewController") as! ChildAViewController
        self.add(asChildVC: vc)
        return vc
    }()
    
    private lazy var vcB:ChildBViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(identifier: "ChildBViewController") as! ChildBViewController
        self.add(asChildVC: vc)
        return vc
    }()
    
    private func add(asChildVC vc:UIViewController){
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        vc.didMove(toParent: self)
    }
    
    private func remove(asChildVC vc:UIViewController){
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    private func setupView(){
        setupSegmentControl()
    }
    
    private func setupSegmentControl(){
        self.segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: "VC-A", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "VC-B", at: 1, animated: true)
        segmentControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
    }
    
    private func updateView(segmentControll: UISegmentedControl){
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildVC: vcB)
            add(asChildVC: vcA)
        }else{
            remove(asChildVC: vcA)
            add(asChildVC: vcB)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentControl()
        updateView(segmentControll: self.segmentControl)
    }
    @IBAction func selectionDidChange(_ segmentController: UISegmentedControl) {
        updateView(segmentControll: segmentController)
        
    }
}
