require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
IRB.conf[:SAVE_HISTORY] = 10000
