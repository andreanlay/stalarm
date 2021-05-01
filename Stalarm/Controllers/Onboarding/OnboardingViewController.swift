//
//  OnboardingViewController.swift
//  Stalarm
//
//  Created by Andrean Lay on 01/05/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getDisciplinedButton: UIButton!
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var titles = [
        "Stalarm",
        "Snooze",
    ]
    
    var desc = [
        "An alarm that improve your self-discipline",
        "Everytime you want snooze an alarm, you need get out of bed and walk first",
    ]
    
    var imgs = ["stalarm-icon", "onboarding-foot"]
    
    let vc = UINavigationController()
    
    override func viewDidLayoutSubviews() {
          scrollWidth = scrollView.frame.size.width
          scrollHeight = scrollView.frame.size.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()

        self.scrollView.delegate = self
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)
            
            let image = UIImageView(image: UIImage.init(named: imgs[index]))
            image.image = UIImage(named: imgs[index])
            image.frame = CGRect(x: 0, y: 0, width: 173, height: 180)
            image.contentMode = .scaleAspectFit
            image.center = CGPoint(x: scrollWidth / 2, y: scrollHeight / 2 - 100)

            let txt1 = UILabel(frame:CGRect(x: image.frame.minX - 60, y: self.view.center.y - 150, width: 300,height: 200))
            txt1.textAlignment = .center
            txt1.font = UIFont.systemFont(ofSize: 36.0)
            txt1.numberOfLines = 0
            txt1.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            txt1.text = titles[index]

            let txt2 = UILabel(frame: CGRect(x: image.frame.minX - 60,y: self.view.center.y - 90, width: 300, height: 200))
            txt2.textAlignment = .center
            txt2.numberOfLines = 0
            txt2.font = UIFont.systemFont(ofSize: 20.0)
            txt2.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            txt2.text = desc[index]

            slide.addSubview(txt1)
            slide.addSubview(txt2)
            slide.addSubview(image)
            scrollView.addSubview(slide)
        }

        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count) , height: scrollHeight)
        self.scrollView.contentSize.height = 1.0

        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }
}

extension OnboardingViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
 
        self.getDisciplinedButton.isHidden = (pageControl?.currentPage == 0)
    }
}
