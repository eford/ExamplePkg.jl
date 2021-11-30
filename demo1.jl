using ExamplePkg

function parse_args_for_demo(argv::Vector{String})
  if length(argv) != 3
     @error("Usage:  demo x mu sigma")
     exit()
  end
  args = try
     (; zip((:x,:mu,:sigma), parse.(Float64, argv) )... )
  catch ex
     @error("Error parsing arguments.\nx mu and sigma must all be floating point numbers.")
     exit()
  end
  @assert(!isnan(args[:x]) && !isinf(args[:x]))
  @assert(!isnan(args[:mu]) && !isinf(args[:mu]))
  @assert(!isnan(args[:sigma]) && !isinf(args[:sigma]))
  @assert(args[:sigma]>0)
  return args 
end

x, mu, sigma = parse_args_for_demo(ARGS)

result = pdf_normal(x,mu,sigma)
println("prob(x | mu, sigma) = ", result)

