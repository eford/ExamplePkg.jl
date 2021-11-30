using ExamplePkg

# To avoid compiling the command-line parsing, here we moved that into the module, as well.  
x, mu, sigma = ExamplePkg.parse_args_for_demo(ARGS)

result = pdf_normal(x,mu,sigma)
println("prob(x | mu, sigma) = ", result)

