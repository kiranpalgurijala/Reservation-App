//
//  MassageListViewController.swift
//  Reservation
//
//  Created by Kiranpal Reddy Gurijala on 1/27/17.
//  Copyright © 2017 AryaVahni. All rights reserved.
//

import UIKit

class MassageListViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    //MARK: Initializing pages array for Page View Control
    let pages = ["MothersDayViewController", "HotStoneViewController", "DeepTissueViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
    }
    
    //MARK: - View controller life cycle methods
   override func viewDidAppear(_ animated: Bool) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MothersDayViewController")
        setViewControllers([vc!], // Has to be a single item array, unless you're doing double sided stuff I believe
            direction: .forward,
            animated: true,
            completion: nil)
        super.viewDidAppear(true)
    }
    
    // MARK: - Page view delegate & data source methods with circular infinte scroll implementation
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let identifier = viewController.restorationIdentifier {
            if var index = pages.index(of: identifier) {
                if index == 0 || index == NSNotFound {
                    index = pages.count
                }
                index-=1
                return self.storyboard?.instantiateViewController(withIdentifier: pages[index])
                
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let identifier = viewController.restorationIdentifier {
            if var index = pages.index(of: identifier) {
                if index == NSNotFound {
                    return nil
                }
                index+=1
                if(index == pages.count){
                    index=0
                }
                    return self.storyboard?.instantiateViewController(withIdentifier: pages[index])
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        if let identifier = viewControllers?.first?.restorationIdentifier {
            if let index = pages.index(of: identifier) {
                return index
            }
        }
        return 0
    }
    //MARK: Method to position page control
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds 
            }
            else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
                view.frame.origin.y = self.view.frame.size.height - 264
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
