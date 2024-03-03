import SwiftUI

struct Saving: Identifiable {
    var id = UUID()
    var amount: Double
    var date: Date
}

struct ViewSavingView: View {
    // Assuming savings are stored in an array. Replace it with your actual data structure.
    var savings: [Saving] = []

    var body: some View {
        NavigationView {
            VStack {
                Text("View Saving")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                List(savings, id: \.id) { saving in
                    VStack(alignment: .leading) {
                        Text("Amount: \(saving.amount)")
                       // Text("Date: \(saving.date, formatter: DateFormatter.shortDate)")
                    }
                }
            }
            .navigationBarTitle("View Saving", displayMode: .inline)
        }
    }
}
