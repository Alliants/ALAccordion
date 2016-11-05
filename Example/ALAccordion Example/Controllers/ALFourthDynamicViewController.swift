//
//  ALFourthDynamicViewController.swift
//  ALAccordion Example
//
//  Created by Sam Williams on 14/02/2016.
//  Copyright © 2016 Alliants Ltd. All rights reserved.
//

import UIKit

import ALAccordion

class ALFourthDynamicViewController: UIViewController, ALAccordionSectionDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        // Add gesture recognizer to header
        self.headerView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        )

        if let removableHeaderView = self.headerView as? ALRemovableHeaderView
        {
            removableHeaderView.closeButton.addTarget(self, action: #selector(btnRemovePressed(_:)), for: .touchUpInside)
        }
    }

    //
    // MARK: - ALAccordionControllerDelegate
    //

    // The header view for this section
    let headerView: UIView =
    {
        let header = ALRemovableHeaderView()
        header.titleLabel.text = "Dynamic Section Header"
        header.topSeparator.alpha = 0

        return header
    }()

    func sectionWillOpen(animated: Bool)
    {
        print("Dynamic Section Will Open")
    }

    func sectionWillClose(animated: Bool)
    {
        print("Dynamic Section Will Close")
    }

    func sectionDidOpen()
    {
        print("Dynamic Section Did Open")
    }

    func sectionDidClose()
    {
        print("Dynamic Section Did Close")
    }

    //
    // MARK: - Gesture Recognizer
    //

    func headerTapped(_ recognizer: UITapGestureRecognizer)
    {
        // Get the section index for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            print("First view controller header tapped")

            // If this section is open, close it - otherwise, open it
            if self.accordionController!.openSectionIndex == sectionIndex
            {
                self.accordionController?.closeSectionAtIndex(sectionIndex, animated: true)
            }
            else
            {
                self.accordionController?.openSectionAtIndex(sectionIndex, animated: true)
            }
        }
    }

    //
    // MARK: - Button Handlers
    //

    func btnRemovePressed(_ sender: UIButton)
    {
        // Get the section for this view controller
        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            self.accordionController?.removeSectionAtIndex(sectionIndex, animated: true)
        }
    }

    @IBAction func btnAddSectionPressed(_ sender: AnyObject)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        let sectionViewController = storyboard.instantiateViewController(withIdentifier: "fourthVC") as! ALFourthDynamicViewController

        // Add a new section to the accordion, then close
        self.accordionController?.addViewController(sectionViewController, animated: true)

        if let sectionIndex = self.accordionController?.sectionIndexForViewController(self)
        {
            self.accordionController?.closeSectionAtIndex(sectionIndex, animated: true)
        }
    }
}
