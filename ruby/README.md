# ruby

Reproduction using the latest [`dotiw`](https://rubygems.org/gems/dotiw) gem (5.6.0 from
RubyGems, which includes the fixes for the original Norfolk Island and Dublin bugs from
`dotiw` issues [#63](https://github.com/radar/distance_of_time_in_words/issues/63) and
[#153](https://github.com/radar/distance_of_time_in_words/issues/153)).

Clean on the Norfolk Island permanent offset-change case, the Dublin DST fall-back case,
reversed argument order, and zero distance -- as expected, since these are the bugs that
started this whole investigation and have already been fixed upstream. This is included
mainly as a baseline/control alongside all the other languages tested here.

Run with:

```
bundle install && bundle exec ruby test.rb
```
