To install Julia on your system follow the instructions on the [Julia Language Downloads page](http://julialang.org/downloads/).

For a local installation, it is recommended to use [Juno](http://junolab.org/). It's an IDE based on Atom and offers a powerful text editor as well as additional features for developing in Julia. Just follow the instructions on their website.

A simple way to get started with Julia without the need of a local installation is [JuliaBox](http://junolab.org/), which is an online IDE based on Jupyter notebooks. You just access it from your browser, login and you can start solving exercises.

---

### Sidenotes

During the installation of Juno, a common issue is that building some dependencies fail. To fix this, make sure you have the required build tools for your operating system installed. You can find more info on how to fix it [here](https://github.com/JuliaWeb/HttpParser.jl/issues/52) (OSX) and [here](http://discuss.junolab.org/t/not-able-to-install-juno-via-atom/562/18). Sometimes it can help to close Atom, run `using Atom` in a Julia REPL, i.e. the Julia command line, and then open Atom again.

While not necessary for the exercism exercises, you will likely run across Julia packages that require a python installation. JuliaBox already comes with one by default. If you use a local installation, check out the [Conda.jl](https://github.com/JuliaPy/Conda.jl) package, which provides an easy way to install Python dependencies. Alternatively, [Anaconda](https://www.continuum.io/downloads) offers a Python distribution that already ships with many of the most popular scientific Python libraries.
