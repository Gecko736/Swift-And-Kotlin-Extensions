extension UIColor {
    convenience init(a: Int = 255, r: Int, g: Int, b: Int) {
        self.init(displayP3Red: CGFloat(Float(r) / 255.0), green: CGFloat(Float(g) / 255.0), blue: CGFloat(Float(b) / 255.0), alpha: CGFloat(Float(a) / 255.0))
    }
}
