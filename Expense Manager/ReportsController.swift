//
//  CustomCollectionViewCell.swift
//  Expense Manager
//
//  Created by Kamlesh on 2022-12-08.
//
import Charts
import UIKit

class ReportsController: UIViewController, ChartViewDelegate {
    var pieChart = PieChartView()
    var income = 0.0
    var expence = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width - 20,
                                height: self.view.frame.size.height - 20)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
        var entries = [ChartDataEntry]()
        
        print("INCOME IS \(income) AND EXPENSE IS \(expence)")
        entries.append(PieChartDataEntry(value: income, label: "$Income"))
        entries.append(PieChartDataEntry(value: expence, label: "$Expense"))
        
        let e1 = NSUIColor(cgColor: UIColor.green.cgColor)
        let e2 = NSUIColor(cgColor: UIColor.red.cgColor)
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.colors = [e1,e2]
        var black = NSUIColor(cgColor: UIColor.black.cgColor)
        set.entryLabelColor = black
        set.valueColors = [black,black]
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }
}
