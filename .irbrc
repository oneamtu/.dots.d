#!/usr/bin/env ruby
# IRB configuration - consider using 'pry' for a better REPL experience

if defined? IRB
  require 'irb/completion'
  require 'irb/ext/save-history'

  IRB.conf[:SAVE_HISTORY] = 10000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
  IRB.conf[:PROMPT_MODE] = :SIMPLE
  IRB.conf[:AUTO_INDENT] = true

  # Colorize output if available
  begin
    require 'irb/color'
    IRB.conf[:USE_COLORIZE] = true
  rescue LoadError
    # Colorization not available in older Ruby versions
  end
end
