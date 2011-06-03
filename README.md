# ShuFaZuoPin

A Rails 3.1RC1 App for learning chinese language. Currently i18n only for german language, but the translations of all characters is english.
Users can add words to their learning lists and then start to learn. If passed correctly, the word will advance to the next level, resulting in a later appearance based on spaced learning paradigm.

This app can be used by multple users at the same time, sharing the same fundus of characters.

For pronounciation I am using the color codes proposed by my Chinese learning book Liaoliao, which are:

* blue for 1st tone
* green for 2nd tone
* yellow for 3rd tone
* red for 4th tone
* these can be changed in app/assets/stylesheets/selections.css.scss

for my experience, codings the hanzi characters in the respective color is effective for learning correct pronounciation.

There are some rake tasks for importing a lot of basic hanzi characters from some webservices. Use that if needed to include a whole bunch of characters, make it very convienient to add that to your list

For a efficient learning, there are hotkeys for interacting with the software in training:

* w: solve
* a: wrong (-1 level)
* s: not quiet right, but also totally not wrong :) (+-0 level)
* d: right (+1 level)

## Todo/plans

* add multi character words
* problem-list and statistics, to find out words that are not so save in memory
* english i18n if wished (just a matter of work)
* design could be pimped
* caching if necessary (until now works fine)
* integrating 3rd party services for more information about words/character etymology and radicals

## Collaboration

* Feedback is welcome
* pull requests are very welcome :)

## Disclaimer

This app is a rapid prototype mark 2 from a sunday. Some of the logic aspects are tested where most of the html is untested.


