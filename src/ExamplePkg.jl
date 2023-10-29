"Package demontrating how to make your code into a Julia pacakge"
module ExamplePkg

using Distributions

export pdf_normal

"""
   pdf_normal(x, mu, sigma)

Return pdf of a normal distribution with mean mu and standard deviation sigma at point x.
"""
function pdf_normal(x::Number, mu::Number, sigma::Number)
  dist = Normal(mu,sigma)
  pdf(dist,x)
end

# The code below is optional.  It serves to demonstrate how to make a program use the module code above.

"Parse command-line arguements for demo program"
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

"""
Demo program to evaluate normal PDF from command line.
To make an executable, make a new directory, activate it, create a new Project.toml, add PackageCompiler, and develope this repository.  Then
```julia
using PackageCompiler
create_app(joinpath(homedir(),".julia","dev","ExamplePkg"), "example_pkg", executables=["demo"=>"julia_main",], incremental=true)
For more information, see [PackageCompiler.jl](https://julialang.github.io/PackageCompiler.jl/stable/apps.html)
```
"""
function julia_main()::Cint
  x, mu, sigma = parse_args_for_demo(ARGS)
  result = pdf_normal(x,mu,sigma)
  println("prob(x | mu, sigma) = ", result)
  return 0 # if things finished successfully
end

println("# Precompiling common signatures...")
# Instruct Julia to pre-compile a functions with concrete types
precompile(pdf_normal,(Float64,Float64,Float64,))

end # module

