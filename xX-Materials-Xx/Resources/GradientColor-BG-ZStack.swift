ZStack{
                Rectangle()
                        .fill(LinearGradient(
                          gradient: gradient,
                          startPoint: .init(x: 0.00, y: 0.50),
                          endPoint: .init(x: 1.00, y: 0.50)
                        ))
                      .edgesIgnoringSafeArea(.all)
             }
