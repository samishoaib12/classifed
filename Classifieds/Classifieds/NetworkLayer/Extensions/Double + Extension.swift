import Foundation

extension Double {

    /// Formats the receiver as a currency string using the specified three digit currencyCode. Currency codes are based on the ISO 4217 standard.
    func formatAsCurrency(currencyCode: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.currencyCode = currencyCode
        currencyFormatter.numberStyle = .currency
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.locale = Locale(identifier: "en_GB")
        //currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
        return currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func formatAsCurrency() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    
}
