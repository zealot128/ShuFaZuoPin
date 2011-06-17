# ShuFaZuoPin

A Rails 3.1RC3 App for learning chinese language. Currently i18n only for
English and German available.  Users can add words to their learning lists
(flash cards) and then start to learn. If passed correctly, the word will
advance to the next level, resulting in a later appearance based on spaced
learning paradigm.

# Installation

    git clone https://github.com/zealot128/ShuFaZuoPin
    cd ShuFaZuoPin
    bundle
    cp config/database.yml.example config/database.yml
    ...
    bundle
    migrate

Startup Server, create a user. Go to rails console and make yourself admin.
Only so, you can edit the Words/Characters, which are shared across all users


# Usage

This app can be used by multple users at the same time, sharing the same fundus
of characters.  For pronounciation I am using the color codes proposed by my
Chinese learning book *LiaoLiao*, which are:

* blue for 1st tone
* green for 2nd tone
* yellow for 3rd tone
* red for 4th tone
* these can be changed in app/assets/stylesheets/selections.css.scss

For my experience, coding the hanzi characters in the respective color is
effective for learning correct pronounciation.

There is a rake tasks for importing a lot of basic hanzi characters from some
webservices. Use that if needed to include a whole bunch of characters, make it
very convienient to add that to your list.  Open *lib/tasks/import.rake* and
see by yourself plz. The rake tasks will maybe not work directly and will need
adjustments

For a efficient learning, there are hotkeys for interacting with the software in training:

* w: solve
* a: wrong (-2 level)
* s: not quiet right, but also totally not wrong :) (+-0 level)
* d: right (+1 level)

Then the word will show up later, according to models/selection.rb

      time = case level
             when 0 then lambda {5.minutes}
             when 1 then lambda {10.minutes }
             when 2 then lambda {60.minutes }
             when 3 then lambda {6.hour }
             when 4 then lambda {1.day}
             when 5 then lambda {7.days}
             when 6 then lambda {25.days}
             when 7 then lambda {2.months}
             when 8 then lambda {7.months}
             else raise "Error"
             end
      time.call.from_now

## Todo/plans

* problem-list and statistics, to find out words that are not so save in memory
* Saving traditional chinese characters in addition to simplified for all the
  university students. Let user choose in his profile, which one to learn
* every user can make notes for word. Share or private visibility
* in case of more users: statistics, highscores etcpp
* improved first-installation
  * until now, you have to create the admin user manually with rails console
  * provide the imported word standard database from cedict. Up to now database
    is empty on delivery
* User administration features for admin. standard community features etcpp

## Already done

* add multi character words
* design could be pimped
* Integration Etymology if applied https://github.com/bastien/ciyuan
* caching if necessary (until now works fine)
* english i18n if wished (just a matter of work)
* SQL Caching for list views

## Collaboration

* Feedback is welcome
* pull requests are very welcome :)

## Disclaimer

This app is work in progress. Some of the logic aspects are tested where most
of the html is untested. So there is no warranty at all.  I am not a native
English speaker, so the translation should have some mistakes. :) (-> which
leads to forks and pull requests again)


