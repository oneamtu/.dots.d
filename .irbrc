#!/usr/bin/ruby

if defined? IRB
  require 'irb/completion'
  require 'irb/ext/save-history'

  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

  IRB.conf[:PROMPT_MODE] = :SIMPLE
end
