# ~/.irbrc
require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'

#ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

IRB.conf[:SAVE_HISTORY] = 10000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/etc/irb_history"
IRB.conf[:IGNORE_EOF] = true
