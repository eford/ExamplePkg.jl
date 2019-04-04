module ExamplePkg

using Distributions

export pdf_normal

function pdf_normal(x::Number, mu::Number, sigma::Number)
  dist = Normal(mu,sigma)
  pdf(dist,x)
end

end # module


