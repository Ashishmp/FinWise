import SwiftUI
import Charts
import DGCharts

struct PieChartView: UIViewRepresentable {
    let label: String
    let needsPercentage: Double
    let wantsPercentage: Double
    let savingsPercentage: Double

    class Coordinator: NSObject, ChartViewDelegate {
        var parent: PieChartView

        init(parent: PieChartView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> PieChartView {
        let chartView = PieChartView()
        chartView.delegate = context.coordinator
        return chartView
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {
        let entries = [
            ChartDataEntry(x: 0, y: needsPercentage, data: "Needs"),
            ChartDataEntry(x: 1, y: wantsPercentage, data: "Wants"),
            ChartDataEntry(x: 2, y: savingsPercentage, data: "Savings")
        ]

        let dataSet = PieChartDataSet(entries: entries, label: nil)
        dataSet.colors = ChartColorTemplates.material()

        let data = PieChartData(dataSet: dataSet)
        uiView.data = data
        uiView.centerText = label
        uiView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .easeInOutQuad)
    }
}

struct StrategyPageView: View {
    // Ideal strategy percentages
    let idealNeedsPercentage: Double = 50
    let idealWantsPercentage: Double = 30
    let idealSavingsPercentage: Double = 20

    // Dummy transaction data (replace with actual data)
    let transactions = [
        Transaction(category: .needs, amount: 500),
        Transaction(category: .wants, amount: 300),
        Transaction(category: .savings, amount: 200),
        // Add more transactions as needed
    ]

    var body: some View {
        ScrollView {
            VStack {
                Text("Ideal Strategy")
                    .font(.title)

                PieChartView(label: "Ideal Strategy", needsPercentage: idealNeedsPercentage, wantsPercentage: idealWantsPercentage, savingsPercentage: idealSavingsPercentage)
                    .frame(height: 300)

                Text("Your Strategy")
                    .font(.title)

                // Calculate percentages based on transaction data
                let totalAmount = transactions.map { $0.amount }.reduce(0, +)
                let userNeedsPercentage = (transactions.first { $0.category == .needs }?.amount ?? 0) / totalAmount * 100
                let userWantsPercentage = (transactions.first { $0.category == .wants }?.amount ?? 0) / totalAmount * 100
                let userSavingsPercentage = (transactions.first { $0.category == .savings }?.amount ?? 0) / totalAmount * 100

                PieChartView(label: "Your Strategy", needsPercentage: userNeedsPercentage, wantsPercentage: userWantsPercentage, savingsPercentage: userSavingsPercentage)
                    .frame(height: 300)

                // Add your dynamic content related to needs, wants, and savings
            }
            .padding()
        }
    }
}

struct Transaction {
    enum Category {
        case needs, wants, savings
    }

    let category: Category
    let amount: Double
}
