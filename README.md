# ROP - Railway Oriented Programming in Elixir

[![Build Status](https://travis-ci.org/ruby2elixir/rop.png)](https://travis-ci.org/ruby2elixir/rop)


Some macros to enable railsway-oriented programming in Elixir.
Collected from code snippets and wrapped into a simple library for your convenience.


For more examples please check the tests here:
- [Examples](https://github.com/ruby2elixir/rop/blob/master/test/rop_test.exs)


### Sources for inspiration + copying
  - https://github.com/remiq/railway-oriented-programming-elixir
  - https://gist.github.com/zabirauf/17ced02bdf9829b6956e (Railway Oriented Programming macros in Elixir)


### Usage

Call

```elixir
use Rop
```

in your module. That will give you access to following macros/functions:

#### `>>>`
No need to stop pipelining in case of an error somewhere in the middle


used like: `1 |> fn1 >>> fn2 >>> fn3 >>> fn4`

```elixir
defmodule TripleArrowExample do
  use Rop
  def tagged_inc(v) do
    IO.puts "inc for #{v}" # sideeffect for demonstration
    {:ok, v + 1}
  end

  def error_fn(_) do
    {:error, "I'm a bad fn!"}
  end

  def raising_fn(_) do
    raise "I'm raising!"
  end

  def result do
    1 |> tagged_inc >>> tagged_inc >>> tagged_inc
  end

  def error_result do
    1 |> tagged_inc >>> tagged_inc >>> error_fn >>> tagged_inc
  end

  def raising_result do
    1 |> tagged_inc >>> tagged_inc >>> raising_fn >>> tagged_inc
  end
end

iex> TripleArrowExample.result
inc for 1
inc for 2
inc for 3
{:ok, 4}

### increases twice, errors and tries to increase again
### notice that after errored result we don't execute any function anymore in the pipeline, e.g. only tagged_inc before error_fn were executed.
iex> TripleArrowExample.error_result
inc for 1
inc for 2
{:error, "I'm a bad fn!"}

### raises... We'll fix it in a later example for try_catch!
iex> TripleArrowExample.raising_result
inc for 1
inc for 2
** (RuntimeError) I'm raising!
```


#### `bind`
Wraps a simple function to return a tagged tuple with `:ok` to comply to the protocol {:ok, result}: e.g.

```elixir
defmodule BindExample do
  use Rop
  def inc(v) do
    v + 1
  end

  def only_last_pipe_tagged_result do
    2 |> inc |> bind(inc)
  end

  def result_fully_tagged do
    2 |> bind(inc) >>> bind(inc) >>> bind(inc)
  end
end
iex> BindExample.only_last_pipe_tagged_result
{:ok, 4}

iex> BindExample.result_fully_tagged
{:ok, 5}
´´´


#### `try_catch`

Wraps raising functions to return a tagged tuple {:error, ErrorMessage} to comply with the protocol

```elixir
# modified example from TripleArrowExample to handle raising functions
defmodule TryCatchExample do
  use Rop
  def tagged_inc(v) do
    IO.puts "inc for #{v}" # sideeffect for demonstration
    {:ok, v + 1}
  end

  def raising_fn(_) do
    raise "I'm raising!"
  end

  def result do
    1 |> tagged_inc >>> tagged_inc >>> tagged_inc
  end

  def raising_result_wrapped do
    1 |> tagged_inc >>> tagged_inc >>> try_catch(raising_fn) >>> tagged_inc
  end
end

iex> TryCatchExample.raising_result_wrapped
inc for 1
inc for 2
{:error, %RuntimeError{message: "I'm raising!"}}


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add rop to your list of dependencies in `mix.exs`:

        def deps do
          [{:rop, "~> 0.5.0"}]
        end


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
  - https://github.com/remiq/railway-oriented-programming-elixir/blob/master/lib/rop.ex
  - https://gist.github.com/zabirauf/17ced02bdf9829b6956e (Railway Oriented Programming macros in Elixir) -> Rop
  - https://github.com/CrowdHailer/OK/blob/master/lib/ok.ex
  - https://gist.github.com/danielberkompas/52216db76d764a68dfa3 -> pipeline.ex
