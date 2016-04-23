# Scientɛst
> A naive performance impact test when running experiments

I was just curious whether the experiments were being run in serial or parallel (forking a process), and the penalty is sort of big.

For full disclosure, you may read the source for the test, but it really is just mapping over a sequence and incrementing each number:

```ruby
(0...100000*factor).map(&:next)
```

Here are the results of running this test for a factor of 1, 10, 100, 1000, and 10000.

> Note: I ommitted the `:predicate` element of the hash to make this more readable:

```zsh
repos/scientest λ for factor in 1 10 100 1000 10000; do ruby test.rb $factor; echo "";  done
Running 3 tests with factor 1...
{:name=>:candidate, :time=>0.06157207489013672}
{:name=>:candidate_no_try, :time=>0.0072209835052490234}
{:name=>:control, :time=>0.007637977600097656}
>> Fastest run:
{:name=>:candidate_no_try, :time=>0.0072209835052490234}
done.

Running 3 tests with factor 10...
{:name=>:candidate, :time=>0.6277220249176025}
{:name=>:candidate_no_try, :time=>0.07044363021850586}
{:name=>:control, :time=>0.07362723350524902}
>> Fastest run:
{:name=>:candidate_no_try, :time=>0.07044363021850586}
done.

Running 3 tests with factor 100...
{:name=>:candidate, :time=>6.157206773757935}
{:name=>:candidate_no_try, :time=>0.7435848712921143}
{:name=>:control, :time=>0.7296631336212158}
>> Fastest run:
{:name=>:control, :time=>0.7296631336212158}
done.

Running 3 tests with factor 1000...
{:name=>:candidate, :time=>62.13065814971924}
{:name=>:candidate_no_try, :time=>7.286419868469238}
{:name=>:control, :time=>7.236094951629639}
>> Fastest run:
{:name=>:control, :time=>7.236094951629639}
done.

Running 3 tests with factor 10000...
{:name=>:candidate, :time=>725.5188598632812}
{:name=>:candidate_no_try, :time=>118.45206713676453}
{:name=>:control, :time=>92.8466100692749}
>> Fastest run:
{:name=>:control, :time=>92.8466100692749}
done.
```

From these numbers it's clear that _using_ Scientist has a great impact on the performance, particularly on computational expensive tasks.
