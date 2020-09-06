#############################################
# PubCMD.tcl 8.0                            #
#############################################
#Creator ComputerTech                       #
#Irc     irc.technet.xi.ht #ComputerTech123 #
#Email   ComputerTech312@Gmail.com          #
#GitHub  https://github.com/computertech312 #
#Website http://tcl3.webnode.co.uk          #
#################################################################################################################################################################
#Start Of Settings

#Set trigger of the commands

set pubcmd ";"

#if you want to change which flags can use which command change the following e.g  o|o

#set flag for normal commands

set flag "o|o"

#set flag for important commands e.g rehash,restart,die

set topflag "n|n"

#End Of Settings
#################################################################################################################################################################

bind pub ${flag} ${pubcmd}ban do_ban_now
bind pub ${flag} ${pubcmd}unban do_unban
bind pub ${flag} ${pubcmd}mute do_mute
bind pub ${flag} "${pubcmd}unmute" do_unmute
bind pub ${flag} "${pubcmd}voice" do_voice
bind pub ${flag} "${pubcmd}devoice" do_devoice
bind pub ${topflag} ${pubcmd}rehash do_rehash
bind pub ${topflag} ${pubcmd}restart do_restart
bind pub ${flag} ${pubcmd}op do_op
bind pub ${flag} ${pubcmd}deop do_deop
bind pub ${topflag} ${pubcmd}die do_die
bind pub ${flag} ${pubcmd}kickban do_kickban
bind pub ${flag} ${pubcmd}kick do_kick
bind pub ${topflag} ${pubcmd}ignore ignore:pub
bind pub ${topflag} ${pubcmd}ignores ignore:list
bind pub ${flag} ${pubcmd}link do_link
bind pub ${flag} ${pubcmd}unlink do_unlink
bind msg ${flag} ${pubcmd}say do_say
bind pub ${flag} ${pubcmd}topic do_topic
bind pub ${flag} ${pubcmd}part do_remv_chan
bind pub ${flag} ${pubcmd}join do_join_chan
bind pub ${flag} ${pubcmd}chanset do_chanset
bind pub ${flag} ${pubcmd}nick do_nick
bind pub ${flag} ${pubcmd}mode do_mode
bind pub ${flag} ${pubcmd}calc Falk.pub:calc
bind pub ${flag} ${pubcmd}fancy Falk:fancy
bind pub ${flag} ${pubcmd}invite do_invite
bind pub ${flag} ${pubcmd}cycle do_cycle
bind pub ${flag} ${pubcmd}ping pPingPubCommand
bind pub ${flag} ${pubcmd}pubhelp do_pub_help

proc do_pub_help { nick uhost hand chan text } {
global pubcmd topflag
putquick "Notice $nick :The following are the commands you can use."
putquick "Notice $nick :${pubcmd}ban {pubcmd}unban {pubcmd}mute {pubcmd}unmute {pubcmd}voice {pubcmd}devoice ${pubcmd}kickban  ${pubcmd}kick ${pubcmd}op ${pubcmd}deop ${pubcmd}voice ${pubcmd}devoice"
putquick "Notice $nick :${pubcmd}topic ${pubcmd}join ${pubcmd}part ${pubcmd}chanset ${pubcmd}nick ${pubcmd}mode ${pubcmd}calc ${pubcmd}fancy ${pubcmd}invite ${pubcmd}cycle ${pubcmd}ping ${pubcmd}pubhelp"

if {[matchattr $nick $topflag]} {
          putquick "Notice $nick :Admin Commands Of PubCmd : ${pubcmd}ignore add ${pubcmd}ignore del ${pubcmd}ignores ${pubcmd}die ${pubcmd}rehash ${pubcmd}restart"
}
}
 

proc do_op {nick uhost hand chan text} {

putquick "mode $chan +o $nick"
}



proc do_deop {nick uhost hand chan text} {
set donick "[lindex [split $text] 0 ]"
if {![botisop $chan]} {
		putquick "privmsg $chan :I'm not op'd"
		return 0
	}
if {![llength [split $text]]} {
   putnow "mode $chan -o $nick"
} else {
putnow "mode $chan -o $donick"
}
}


proc do_ban_now { nick uhost hand chan text } {
	set bnick [lindex [split $text] 0 ]
if {![botisop $chan]} {
		putquick "privmsg $chan :I'm not op'd"
		return 0
	}
    if {[isbotnick $bnick]} {
		putkick $chan $nick "Banning The Bot Wont Be Tolerated"
	}
    if {[matchattr [nick2hand $bnick] n]} {
		putquick "PRIVMSG $chan :I won't ban an owner!"
		putkick $chan $nick "Never Ban The Owner"
	}
    if {[onchan $bnick $chan]} {
		set host "[maskhost $bnick![getchanhost $bnick $chan] 2]"

       putnow "mode $chan +b $host"
 } else {
      putnow "mode $chan +b $bnick"
    }
}

proc do_unban {nick uhost hand chan text} {
set denick "[lindex [split $text] 0 ]"
if {![botisop $chan]} {
		putquick "privmsg $chan :I'm not op'd"
		return 0
	}
if {[onchan $denick $chan]} {
          set host "[maskhost $denick![getchanhost $denick $chan] 2]"
          putquick "mode $chan -b $host"
       putquick "PRIVMSG $chan :$denick Has Been Unbanned"
        } else {
          putnow "mode $chan -b $denick"
   }
}

proc do_mute {nick uhost hand chan text} {
set mnick "[lindex [split $text] 0 ]"
if {![botisop $chan]} {
		putquick "privmsg $chan :I'm not op'd"
		return 0
	}
if {![botisop $chan]} {
   putquick "privmsg $chan :I'm Not Op'd"
          return 0
       }
if {[isbotnick $mnick]} {
   putquick "privmsg $chan :$nick,Banning The Bot Wont Be Tolerated"
          return 0
       }
if {[matchattr [nick2hand $mnick] n]} {
          putquick "PRIVMSG $chan :$nick, Banning The Onwer Wont Be Tolerated"
          return 0 
      }
if {[onchan $mnick $chan]} {
          set host "[maskhost $mnick![getchanhost $mnick $chan] 2]"
          putquick "mode  $chan +b ~q:$host"
       putquick "PRIVMSG $chan :$mnick Has Been Muted"
        } else {
          putquick "mode $chan +b ~q:$mnick"
          putquick "privmsg $chan : $mnick has been Muted"
   }
}

proc do_unmute {nick uhost hand chan text} {
set unmnick "[lindex [split $text] 0 ]"
if {![botisop $chan]} {
		putquick "privmsg $chan :I'm not op'd"
		return 0
	}
if {![botisop $chan]} {
   putquick "privmsg $chan :I'm Not Op'd"
          return 0
       }
if {[isbotnick $unmnick]} {
   putquick "privmsg $chan :$nick,Banning The Bot Wont Be Tolerated"
          return 0
       }
if {[matchattr [nick2hand $unmnick] n]} {
          putquick "PRIVMSG $chan :$nick, Banning The Onwer Wont Be Tolerated"
       }
if {[onchan $unmnick $chan]} {
          set host "[maskhost $unmnick![getchanhost $unmnick $chan] 2]"
          putquick "mode  $chan -b ~q:$host"
       putquick "PRIVMSG $chan :$unmnick Has Been Unmuted"
        } else {
          putquick "mode $chan -b ~q:$unmnick"
          putquick "privmsg $chan : $unmnick has been Unmuted"
   }
}

proc do_voice {nick uhost hand chan text} {
set vnick "[lindex [split $text] 0 ]"
if {![botisop $chan]} {
		putquick "privmsg $chan :I'm not op'd"
		return 0
	}
if {![botisop $chan]} {
      putquick "privmsg $chan :I'm not op'd"
   return 0
}
if {![llength [split $text]]} {
   putquick "mode $chan +v $nick"
} else {
putquick "mode $chan +v $vnick"
}
}

proc do_devoice {nick uhost hand chan text} {
set dvnick "[lindex [split $text] 0 ]"
if {![botisop $chan]} {
		putquick "privmsg $chan :I'm not op'd"
		return 0
	}
if {![botisop $chan]} {
      putquick "privmsg $chan :I'm not op'd"
   return 0
}
if {![llength [split $text]]} {
   putquick "mode $chan -v $nick"
} else {
putquick "mode $chan -v $dvnick"
}
}

proc do_rehash {nick uhost hand chan text} {
  putquick "PRIVMSG $chan :Rehash Requested By $nick Rehashing..."
    rehash
}

proc do_restart {nick uhost hand chan text} {
  putquick "PRIVMSG $chan :Restart Requested By $nick Restarting...)"
   restart
  }

proc do_die {nick uhost hand chan text} {
       if {$text == ""} {
          die $nick
       } else { die $text }
    }

proc do_kick {nick uhost hand chan text} {
set knick "[lindex [split $text] 0 ]"
   if {![botisop $chan]} {
      putquick "privmsg $chan :I'm not op'd"
      return 0
   }
   if {[isbotnick $knick]} {
      putquick "privmsg $chan :$nick, Kicking The Bot Wont Be Tolerated"
   } elseif {[matchattr [nick2hand $knick] n]} {
      putquick "privmsg $chan :$nick, Kicking The Owner Wont Be Tolerated"
   } else {
      putquick "kick $chan $knick $text"
 
      }
   }

proc do_kickban {nick uhost hand chan text} {
set kbnick "[lindex [split $text] 0 ]"
if {![botisop $chan]} {
   putquick "privmsg $chan :I'm Not Op'd"
          return 0
       }
if {[isbotnick $kbnick]} {
   putquick "privmsg $chan :$nick,Banning The Bot Wont Be Tolerated"
          return 0
       }
if {[matchattr [nick2hand $kbnick] n]} {
          putquick "PRIVMSG $chan :$nick, Banning The Onwer Wont Be Tolerated"
       }
if {[onchan $kbnick $chan]} {
          set host "[maskhost $kbnick![getchanhost $kbnick $chan] 2]"
          putquick "kick $chan $kbnick $text"
          putquick "mode $chan +b $host"
       putquick "PRIVMSG $chan :$kbnick Has Been Banned"
        
   }
}

proc getpubcmd {} {
       global pubcmd
       return $pubcmd
    }

    proc ignore:pub {nick uhost hand chan text} {
          if {[lindex [split $text] 0] == ""} {putquick "NOTICE $chan :\037ERROR\037: Incorrect Parameters. \037SYNTAX\037: [getpubcmd]ignore add <*!*@host.mask.whatever> <duration:in:minutes> <your reasons whatever> - [getpubcmd]ignore del <*!*@host.mask.whatever>"; return}

          if {[lindex [split $text] 0] == "add"} {
             set addmask [lindex [split $text] 1]
             if {$addmask == ""} {putquick "NOTICE $chan :\037ERROR\037: Incorrect Parameters. \037SYNTAX\037: [getpubcmd]ignore add <*!*@host.mask.whatever> <duration:in:minutes> <your reasons whatever> - [getpubcmd]ignore del <*!*@host.mask.whatever>"; return}
             if {[isignore $addmask]} {putquick "NOTICE $chan :\037ERROR\037: This is already a Valid Ignore."; return}
             set duration [lindex [split $text] 2]
             if {$duration == ""} {putquick "NOTICE $chan :\037ERROR\037: Incorrect Parameters. \037SYNTAX\037: [getpubcmd]ignore add <*!*@host.mask.whatever> <duration:in:minutes> <your reasons whatever> - [getpubcmd]ignore del <*!*@host.mask.whatever>"; return}
             set reason [join [lrange [split $text] 3 end]]
             if {$reason == ""} {putquick "NOTICE $chan :\037ERROR\037: Incorrect Parameters. \037SYNTAX\037: [getpubcmd]ignore add <*!*@host.mask.whatever> <duration:in:minutes> <your reasons whatever> - [getpubcmd]ignore del <*!*@host.mask.whatever>"; return}
             newignore $addmask $hand "$reason" $duration
             putquick "NOTICE $chan :\002New Ignore\002: $addmask - \002Duration\002: $duration minutes - \002Reason\002: $reason"
             return 0
          }

          if {[lindex [split $text] 0] == "del"} {
             set delmask [lindex [split $text] 1]
             if {$delmask == ""} {putquick "NOTICE $chan :\037ERROR\037: Incorrect Parameters. \037SYNTAX\037: [getpubcmd]ignore add <*!*@host.mask.whatever> <duration:in:minutes> <your reasons whatever> - [getpubcmd]ignore del <*!*@host.mask.whatever>"; return}
             if {![isignore $delmask]} {putquick "NOTICE $chan :\037ERROR\037: This is NOT a Valid Ignore."; return}
             killignore $delmask
             putquick "NOTICE $chan :\002Removed Ignore\002: $delmask"
             return 0
          }
       }

    proc ignore:list {nick uhost hand chan text} {
       if {[matchattr [nick2hand $nick] o]} {
          if {[ignorelist] == ""} {
             putquick "NOTICE $nick :\002There are Currently no Ignores\002"
          } else {
             putquick "NOTICE $nick :\002Current Ignore List\002"
             foreach ignore [ignorelist] {
                set ignoremask [lindex $ignore 0]
                set ignorecomment [lindex $ignore 1]
                set ignoreexpire [lindex $ignore 2]
                set ignoreadded [lindex $ignore 3]
                set ignorecreator [lindex $ignore 4]
                set ignoreexpire_ctime [ctime $ignoreexpire]
                set ignoreadded_ctime [ctime $ignoreadded]
                if {$ignoreexpire == 0} {
                   set ignoreexpire_ctime "perm"
                }
                putquick "NOTICE $nick : "
                putquick "NOTICE $nick :\002Mask\002: $ignoremask - \002Set by\002: $ignorecreator."
                putquick "NOTICE $nick :\002Reason\002: $ignorecomment"
                putquick "NOTICE $nick :\002Created\002: $ignoreadded_ctime. - \002Expiration\002: $ignoreexpire_ctime."
             }
          }
       }
    }

 proc do_link {nick ushost handle chan text} {
      global pubcmd  
      if {![llength [split $text]]} {
		putquick "privmsg $chan :Syntax: ${pubcmd}link <bot>"
		return 0
	}
        set 2link [lindex [split $text] 0 ]
        putquick "NOTICE $nick :Linking To $2link"   
       link $2link
    }


    proc do_unlink {nick ushost handle chan text} {
      global pubcmd 
      if {![llength [split $text]]} {
		putquick "privmsg $chan :Syntax: ${pubcmd}unlink <bot>"
		return 0
	}
       set 2unlink [lindex [split $text] 0 ]
       puthelp "Privmsg $chan :Unlinking From $2unlink"
        unlink $2unlink
    }

proc do_say {nick uhost hand args} {
      global botnick pubcmd
      if {[llength [lindex $args 0]]<2} {
          putquick "NOTICE $nick :/msg $botnick ${pubcmd}say <#chan> <something to say>"
      return 0
     } else {
     set chan [lindex [lindex $args 0] 0]
     if { ![validchan $chan]} {
     putquick "NOTICE $nick :\"$chan\": invalid chan."
     return 0
     }
     if { ![onchan $botnick $chan] } {
     putquick "NOTICE $nick :i'm not on the chan \"$chan\"."
     return 0
     }
     set msg [lrange [lindex $args 0] 1 end]
     putquick "PRIVMSG $chan :$msg"
      }
    }

proc do_topic {nick ushost handle chan text} {
   if {![botisop $chan]} {
      puthelp "privmsg $chan :I'm Not Op'd"
   } else {
      set new2topic [lrange $text 0 end]
      putquick "topic $chan :$new2topic"
   }
}

proc do_join_chan {nick uhost handle chan text} {
    global pubcmd
    if {![llength [split $text]]} {
		putquick "privmsg $chan :Syntax: ${pubcmd}join <channel>"
		return 0
	}
    set 1chan [lindex [split $text] 0 ]

    channel add  $1chan

    putquick "privmsg $chan :Successfully Joined $1chan"
    }

    proc do_remv_chan {nick uhost handle chan text} {
    global pubcmd
    if {![llength [split $text]]} {
		putquick "privmsg $chan :Syntax: ${pubcmd}part <channel>"
		return 0
	}
    set 2chan [lindex [split $text] 0 ]

    channel remove $2chan

    putquick "privmsg $chan : Successfully Left $2chan"
    }

proc do_chanset {nick uhost hand chan arg} {
     foreach {set value} [split $arg] {break}
     if {![info exists value]} {
      catch {channel set $chan $set} error
     } {
      catch {channel set $chan $set $value} error 
     }
     if {$error == ""} {
      puthelp "privmsg $chan :Successfully set $arg"
     } {
      puthelp "privmsg $chan :Error setting $arg: [lindex $error 0]..."
     }
    }

    proc do_nick {nick uhost hand chan text} {
    global pubcmd
    if {![llength [split $text]]} {
		putquick "privmsg $chan :Syntax: ${pubcmd} <new nick>"
		return 0
	}
   set newnick [lindex [split $text] 0 ]
   putquick "NICK $newnick"
}

proc do_mode {nick uhost hand chan text} {
      global pubcmd
      if {![llength [split $text]]} {
		putnow "privmsg $chan :Syntax: ${pubcmd}mode <mode>"
		return 0
	}
      if {![botisop $chan]} {
      putquick "privmsg $chan :I'm Not Op'd"
   } else {
      set 2mode [lindex [split $text] 0 ]
      if {[string equal -nocase $2mode "+l"] || [string equal -nocase $2mode "+k"]} {
         set nbl [lindex [split $text] 1 ]
         pushmode $chan $2mode $nbl
      } elseif {[string equal -nocase $2mode "-k"]} {
         set nbl [lindex [split $text] 1 ]
         pushmode $chan $2mode $nbl
      } else {
         putnow "mode $chan $2mode"
      }
   }
}

set falk(err) "\0034Error:\003"

    proc Falk:fancy {ni u h ch t} {
      global calc falk pubcmd
        if {![validuser $h]} { set nk(fl) "?" }
       if {[matchattr $h n|n $ch]} {
          set nk(fl) "*"
       } elseif {[matchattr $h m|m $ch]} {
          set nk(fl) "¤"
       } elseif {[matchattr $h o|o $ch]} {
          set nk(fl) "@"
       } elseif {[matchattr $h f|f $ch]} {
          set nk(fl) "+"
       } else {
          set nk(fl) "?"
       }
      if {[lindex $t 0] == ""} { putlog "<<$nk(fl)$ni>> !$h! ($ch) $${pubcmd}fancy ($falk(err) No word to fancy)" ;putquick $ni "Error: Forgot to specify something to fancy didnt you? ;o)" ;return 0 }
      foreach letter [split $t ""] {
        set rand [randstring 1 {23456789}]
        append total "\0030$rand$letter"
      }
      putlog "<<$nk(fl)$ni>> !$h! ($ch) $${pubcmd}fancy $total"
      putmsg $ch "$total"
      unset total
    }


    proc Falk.pub:calc {ni u h ch t} {
      global calc botnick pubcmd
        if {![validuser $h]} { set nk(fl) "?" }
       if {[matchattr $h n|n $ch]} {
          set nk(fl) "*"
       } elseif {[matchattr $h m|m $ch]} {
          set nk(fl) "¤"
       } elseif {[matchattr $h o|o $ch]} {
          set nk(fl) "@"
       } elseif {[matchattr $h f|f $ch]} {
          set nk(fl) "+"
       } else {
          set nk(fl) "?"
       }
      set what "[lrange $t 0 end]"
      set result "nothing"
        if {($what == "") || ($what == "help") || ($what == "hjelp")} {
          putlog "<<$nk(fl)$ni>> !$h! ($ch) $${pubcmd}help Calc"
          putquick "privmsg $ch : --=={  -=>      Help for: $${pubcmd}Calc        <=-  }==--"
          putquick "privmsg $ch : --=={      Usage: $${pubcmd}calc <num> <param> <num> }==--"
          putquick "privmsg $ch : --=={  Calculate whatever you want...      }==--"
          putquick "privmsg $ch : --=={  Ex: $${pubcmd}calc 5 + 5                      }==--"
          putquick "privmsg $ch : --=={  Shows: <$botnick> Calc: 5 + 5 = 10    }==--"
          putquick "privmsg $ch : --=={  OBS! Just a test script as of now!  }==--"
          return 0
        }

      catch {
      set result "{expr $what}"
      } foo
      if {($foo == "1")} { putlog "<<$nk(fl)$ni>> !$h! ($ch) $${pubcmd}Calc (Error: $what can not be calculated)" ;putchan $ch "$ni: Sorry, $what Can not be calculated! :o(" ;return 0 }
      if {($result == "nothing")} { putlog "<<$nk(fl)$ni>> !$h! ($ch) $${pubcmd}Calc (Error: $what can not be calculated)" ;putchan $ch "$ni: Sorry, $what Can not be calculated! :o(" ;return 0 }
      putlog "<<$nk(fl)$ni>> !$h! ($ch) $${pubcmd}Calc ($what = $result)"
      putchan $ch "\0032Calc\003\037:\037\00312 $what \003=\0033 $result\003"
      return 0
    }
    proc pPingTrigger {} {
  global vPingTrigger
  return $vPingTrigger
}

set vPingTrigger ";"

set vPingVersion 1.1

setudef flag ping

bind CTCR - PING pPingCtcrReceive
bind PUB - [pPingTrigger]ping pPingPubCommand
bind RAW - 401 pPingRawOffline

proc pPingTimeout {} {
  global vPingOperation
  set schan [lindex $vPingOperation 0]
  set snick [lindex $vPingOperation 1]
  set tnick [lindex $vPingOperation 2]
  putserv "PRIVMSG $schan :\00304Error\003 (\00314$snick\003) operation timed out attempting to ping \00307$tnick\003"
  unset vPingOperation
  return 0
}

proc pPingCtcrReceive {nick uhost hand dest keyword txt} {
  global vPingOperation
  if {[info exists vPingOperation]} {
    set schan [lindex $vPingOperation 0]
    set snick [lindex $vPingOperation 1]
    set tnick [lindex $vPingOperation 2]
    set time1 [lindex $vPingOperation 3]
    if {([string equal -nocase $nick $tnick]) && ([regexp -- {^[0-9]+$} $txt])} {
      set time2 [expr {[clock clicks -milliseconds] % 16777216}]
      set elapsed [expr {(($time2 - $time1) % 16777216) / 1000.0}]
      set char "O"
      if {[expr {round($elapsed / 0.5)}] > 10} {set red 10} else {set red [expr {round($elapsed / 0.5)}]}
      set green [expr {10 - $red}]
      set output \00303[string repeat $char $green]\003\00304[string repeat $char $red]\003
      putserv "PRIVMSG $schan :\00310Compliance\003 (\00314$snick\003) $output $elapsed seconds from \00307$tnick\003"
      unset vPingOperation
      pPingKillutimer
    }
  }
  return 0
}

proc pPingKillutimer {} {
  foreach item [utimers] {
    if {[string equal pPingTimeout [lindex $item 1]]} {
      killutimer [lindex $item 2]
    }
  }
  return 0
}

proc pPingPubCommand {nick uhost hand channel txt} {
  global vPingOperation
  if {[channel get $channel ping]} {
    switch -- [llength [split [string trim $txt]]] {
      0 {set tnick $nick}
      1 {set tnick [string trim $txt]}
      default {
        putserv "PRIVMSG $channel :\00304Error\003 (\00314$nick\003) correct syntax is \00307!ping ?target?\003"
        return 0
      }
    }
    if {![info exists vPingOperation]} {
      if {[regexp -- {^[\x41-\x7D][-\d\x41-\x7D]*$} $tnick]} {
        set time1 [expr {[clock clicks -milliseconds] % 16777216}]
        putquick "PRIVMSG $tnick :\001PING [unixtime]\001"
        utimer 20 pPingTimeout
        set vPingOperation [list $channel $nick $tnick $time1]
      } else {putserv "PRIVMSG $channel :\00304Error\003 (\00314$nick\003) \00307$tnick\003 is not a valid nick"}
    } else {putserv "PRIVMSG $channel :\00304Error\003 (\00314$nick\003) a ping operation is still pending, please wait"}
  }
  return 0
}

proc pPingRawOffline {from keyword txt} {
  global vPingOperation
  if {[info exists vPingOperation]} {
    set schan [lindex $vPingOperation 0]
    set snick [lindex $vPingOperation 1]
    set tnick [lindex $vPingOperation 2]
    if {[string equal -nocase $tnick [lindex [split $txt] 1]]} {
      putserv "PRIVMSG $schan :\00304Error\003 (\00314$snick\003) \00307$tnick\003 is not online"
      unset vPingOperation
      pPingKillutimer
    }
  }
  return 0
}

proc do_invite {nick uhost hand chan text} {

    set 2invite [lindex [split $text] 0 ]

    set 4invite [lindex [split $text] 1 ]

    putquick "INVITE : $2invite $4invite"

    }

   proc do_cycle {nick uhost hand chan text} {
   if {[lindex [split $text] 0 ] != ""} {
      set 2cycle [lindex [split $text] 0 ]
   } else {
      set 2cycle $chan
   }
   putquick "PART $2cycle"
}

putlog "PubCMD.tcl By ComputerTech Loaded"
#################################################################################################################################################################
#################################################################################################################################################################

