//
//  ComposeViewController.swift
//  DWWB
//
//  Created by xmg on 16/4/14.
//  Copyright © 2016年 NewDee. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    // MARK: - 懒加载属性
    private lazy var titleView : ComposeTitleView = ComposeTitleView()
    @IBOutlet weak var textView: ComposeTextView!

    // MARK: - 约束的属性
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!

    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置导航栏
        setupNavigationBar()

        // 监听通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardDidChangeFrameNotification, object: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        textView.becomeFirstResponder()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

// MARK: - 设置UI界面
extension ComposeViewController{
    private func setupNavigationBar() {
        // 1.设置左右的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "closeItemClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: "sendItemClick")
        navigationItem.rightBarButtonItem?.enabled = false

        // 2.设置标题
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = titleView

    }
}

// MARK: - 事件监听函数
extension ComposeViewController {
    @objc private func closeItemClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @objc private func sendItemClick() {
        print("sendItemClick")
    }

    @objc private func keyboardWillChangeFrame(note : NSNotification) {
        // 1.获取动画执行的时间
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval

        // 2.获取键盘最终Y值
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let y = endFrame.origin.y

        // 3.计算工具栏距离底部的间距
        let margin = UIScreen.mainScreen().bounds.height - y

        // 4.执行动画
        toolBarBottomCons.constant = margin
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITextView的代理
extension ComposeViewController : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        self.textView.placeHolderLabel.hidden = textView.hasText()
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}




