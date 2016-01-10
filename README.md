# ROP - Railway Oriented Programming in Elixir


[![Build Status](https://travis-ci.org/ruby2elixir/rop.png)](https://travis-ci.org/ruby2elixir/rop)


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add rop to your list of dependencies in `mix.exs`:

        def deps do
          [{:rop, "~> 0.5.0"}]
        end

  2. Ensure rop is started before your application:

        def application do
          [applications: [:rop]]
        end


### Sources for inspiration + copying
  - https://github.com/remiq/railway-oriented-programming-elixir
  - https://gist.github.com/zabirauf/17ced02bdf9829b6956e (Railway Oriented Programming macros in Elixir)


### Some discussions about Railsway programming:
  - http://insights.workshop14.io/2015/10/18/handling-errors-in-elixir-no-one-say-monad.html
  - http://blog.danielberkompas.com/2015/09/03/better-pipelines-with-monadex.html
  - http://onor.io/2015/08/27/railway-oriented-programming-in-elixir/
  - http://www.zohaib.me/railway-programming-pattern-in-elixir/
  - http://www.zohaib.me/monads-in-elixir-2/
  - http://fsharpforfunandprofit.com/posts/recipe-part2/
  - https://www.reddit.com/r/programming/comments/30coly/railway_oriented_programming_in_elixir/


### Code (Monads)

  - https://github.com/rmies/monad.git
  - https://github.com/rob-brown/MonadEx.git

### Code (Railsway Programming)

  - https://github.com/CrowdHailer/OK/blob/master/lib/ok.ex
  - https://github.com/remiq/railway-oriented-programming-elixir/blob/master/lib/rop.ex
  - https://gist.github.com/zabirauf/17ced02bdf9829b6956e (Railway Oriented Programming macros in Elixir) -> Rop
  - https://gist.github.com/danielberkompas/52216db76d764a68dfa3 -> pipeline.ex
