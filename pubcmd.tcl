#################################################################################################################################################################
# PubCMD.tcl 6.0
################################################################################################################################################################
#ComputerTech
#IRC Irc.mindforge.org #ComputerTech123
#EMAIL COMPUTERTECH312@GMAIL.COM
#GitHub  https://github.com/computertech312
#################################################################################################################################################################
#START OF SETTINGS#

#Set trigger

set pubcmd "?"

#if you want to change which flags can use which command change the following e.g   o|o

#set flag for normal commands

set flag "o|o"

#set flag for important commands

set topflag "n|n"

#END OF SETTINGS#
#################################################################################################################################################################

bind pub ${flag} ${pubcmd}ban do_ban
bind pub ${flag} ${pubcmd}unban do_unban
bind pub ${flag} ${pubcmd}mute do_mute
bind pub ${flag} ${pubcmd}unmute do_unmute
bind pub ${flag} ${pubcmd}voice do_voice
bind pub ${flag} ${pubcmd}devoice do_devoice
bind pub ${flag} ${pubcmd}rehash do_rehash
bind pub ${flag} ${pubcmd}restart do_restart
bind pub ${flag} ${pubcmd}op do_op
bind pub ${flag} ${pubcmd}deop do_deop
bind pub ${topflag} ${pubcmd}die do_die
bind pub ${topflag} ${pubcmd}ignore ignore:pub
bind pub ${topflag} ${pubcmd}ignores ignore:list
bind pub ${flag} ${pubcmd}kick do_kick
bind pub ${flag} ${pubcmd}kickban do_kickban
bind pub ${flag} ${pubcmd}link do_link
bind pub ${flag} ${pubcmd}unlink do_unlink
bind pub ${flag} ${pubcmd}link do_link
bind msg ${flag} ${pubcmd}say do_say
bind pub ${flag} ${pubcmd}topic do_set_topic
bind pub ${flag} ${pubcmd}join do_join_chan
bind pub ${flag} ${pubcmd}chanset pub:chanset 
bind pub ${flag} ${pubcmd}part do_remv_chan
bind pub ${flag} ${pubcmd}pubhelp do_pub_help
bind pub ${flag} ${pubcmd}nick do_nick
bind pub ${flag} ${pubcmd}mode do_mode

proc do_pub_help { nick uhost hand chan text } {

putserv "Notice $nick :The Following Are The Commands Of PubCmd The Trigger You Have Set Will Be Infront Of Each Of These Commands"
putserv "Notice $nick :ban , unban , mute , unmute , voice , devoice ,rehash , restart , op , deop , die"
putserv "Notice $nick :ignore , ignores , kick , kickban , link , unlink , topic , join , part , mode , puthelp "
putserv "Notice $nick :/msg (botnick) say (message)  (this is the only command that doesnt change)" 
}

proc do_ban { nick uhost hand chan text } {


	if {![botisop $chan]} {
		putserv "privmsg $chan :I'm Not Op'd"
		return 0
	}

	set bnick [lindex [split $text] 0 ]

	if {[isbotnick $bnick]} {
		putkick $chan $nick "Banning The Bot Wont Be Tolerated"
	}

	if {[matchattr [nick2hand $bnick] n]} {
		putserv "PRIVMSG $chan :I won't ban an owner!"
		putkick $chan $nick "Never Ban The Owner"
	}

	
	if {[onchan $bnick $chan]} {
		set host "[maskhost $bnick![getchanhost $bnick $chan] 2]"
		pushmode $chan +b $host
	putserv "PRIVMSG $chan :$bnick Has Been Banned"
    } else {
		pushmode $chan +b $bnick
    

	}

}
proc do_unban { nick uhost hand chan text } {


	if {![botisop $chan]} {
		putserv "privmsg $chan :I'm Not Op'd"
		return 0
	}

	set unbnick [lindex [split $text] 0 ]

	if {[onchan $unbnick $chan]} {
		set uhost "[maskhost $unbnick![getchanhost $unbnick $chan] 2]"
		pushmode $chan -b $uhost
	    putserv "PRIVMSG $chan :$unbnick Has Been Unbanned"
    } else {
		pushmode $chan -b $unbnick

	}

}

proc do_mute {nick uhost hand chan text} {


	if {![botisop $chan]} {
		putserv "privmsg $chan :I'm Not Op'd"
		return 0
	}

	set mnick [lindex [split $text] 0 ]

	if {[isbotnick $mnick]} {
		putserv "$chan $nick :Muting The Bot Wont Be Tolerated"
	}

	if {[matchattr [nick2hand $mnick] n]} {
		putserv "PRIVMSG $chan :I won't Mute an owner!"
		
	}

    if {[isvoice $mnick $chan]} {
		set mhost "[maskhost $mnick![getchanhost $mnick $chan] 2]"
		pushmode $chan -v $mnick
    }

	if {[onchan $mnick $chan]} {
		set mhost "[maskhost $mnick![getchanhost $mnick $chan] 2]"
		pushmode $chan +b $mhost
        putserv "PRIVMSG $chan :$mnick Has Been Muted"
      


	}

}

proc do_unmute {nick uhost hand chan text} {

if {![botisop $chan]} {
		putserv "privmsg $chan :I'm Not Op'd"
		return 0
	}

	set unmnick [lindex [split $text] 0 ]

	set unmhost [getchanhost $unmnick $chan]
	if {[onchan $unmnick $chan]} {
		pushmode $chan -b [maskhost $unmnick!$unmhost 2]

		putserv "privmsg $chan :$unmnick has been Unmuted"

	}
}



proc do_voice { nick uhost hand chan text } {

	if {![botisop $chan]} {
		putserv "privmsg $chan :/<pssst!/>  I'm not op'd "
		return 0
	}

	set 2voice [lindex [split $text] 0 ]

	if {![onchan $2voice $chan]} {
		putserv "privmsg $chan :$nick currently $2voice is not on $chan"
		return 0
}
    if {[isvoice $2voice $chan]} {
        putserv "privmsg $chan :$2voice Already Has Voice"
        return 0
  }
		putquick "MODE $chan +v $2voice"
 }

proc do_devoice { nick uhost hand chan text } {

	if {![botisop $chan]} {
		putserv "privmsg $chan :/<pssst!/>  I'm not op'd  "
		return 0
	}

set 2devoice [lindex [split $text] 0 ]
    if {![isvoice $2devoice $chan]} {
   
}
	if {![onchan $2devoice $chan]} {
		putserv "privmsg $chan :$nick currently $2devoice is not on $chan"
		return 0
}
		putquick "MODE $chan -v $2devoice"


}

proc do_rehash { nick uhost hand chan text } {
	putquick "PRIVMSG $chan :Rehash Requested By $nick Rehashing..."
	rehash
}

proc do_restart { nick uhost hand chan text } {
	putquick "PRIVMSG $chan :Restart Requested By $nick Restarting...)"
	restart
}


proc do_op { nick uhost hand chan text } {

	if {![botisop $chan]} {
		putserv "privmsg $chan :I'm not op'd"
		return 0
	}

	set 2op [lindex [split $text] 0 ]

 if {[isop $2op $chan]} {
        putserv "privmsg $chan :$2op Already Has Ops"
        return 0
}
	putquick "MODE $chan +o $2op"
}

proc do_deop { nick uhost hand chan text } {

	if {![botisop $chan]} {
		putserv "privmsg $chan :I'm not op'd"
		return 0
	}
 
set 2deop [lindex [split $text] 0 ]

if {![isop $2deop $chan]} {
        putserv "privmsg $chan :$2deop Doesnt Have Ops"
        return 0
}


	putquick "MODE $chan -o $2deop"
}

proc do_die { nick uhost hand chan text } {
	if {$text == ""} {
		die $nick
	} else { die $text }
}

proc do_kick {nick uhost handle chan text} {

	set 2kick [lindex [split $text] 0 ]

if {![botisop $chan]} {
		putserv "privmsg $chan :I'm Not Op'd"
		return 0
	}


	if {[isbotnick $2kick]} {
		putkick $chan $nick "Kicking The Bot Wont Be Tolerated"
	}

	if {[matchattr [nick2hand $2kick] n]} {
		putserv "PRIVMSG $chan :I won't Kick an owner!"
		putkick $chan $nick "Never Kick The Owner"
	}

	
	if {[onchan $2kick $chan]} {
      putquick "kick $chan $2kick"
	}

}



proc do_kickban {nick uhost hand chan text} {

	if {![botisop $chan]} {
		putserv "privmsg $chan :I'm Not Op'd"
		return 0
	}

	set kbnick [lindex [split $text] 0 ]

	set kbhost [getchanhost $kbnick $chan]
	if {[onchan $kbnick $chan]} {
		pushmode $chan +b [maskhost $kbnick!$kbhost 2]
		putquick "MODE $chan +b $kbnick"
	      flushmode $chan 
             putquick "kick $chan $kbnick"
            putserv "privmsg $chan :$kbnick has been KickBanned"

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
				putserv "NOTICE $nick : "
				putserv "NOTICE $nick :\002Mask\002: $ignoremask - \002Set by\002: $ignorecreator."
				putserv "NOTICE $nick :\002Reason\002: $ignorecomment"
				putserv "NOTICE $nick :\002Created\002: $ignoreadded_ctime. - \002Expiration\002: $ignoreexpire_ctime."
			}
		}
	}
}


proc do_link {nick ushost handle chan text} {
	set 2link [lindex [split $text] 0 ]
    putquick "NOTICE $nick :Linking To $2link"    
	link $2link
}


proc do_unlink {nick ushost handle chan text} {
	set 2unlink [lindex [split $text] 0 ]
	puthelp "Privmsg $chan :Unlinking From $2unlink"
    unlink $2unlink
}


proc do_say {nick uhost hand args} {
	global botnick
	if {[llength [lindex $args 0]]<2} {
		putserv "NOTICE $nick :/msg $botnick !say <#chan> <something to say>"
	} else {
		set chan [lindex [lindex $args 0] 0]
		if { ![validchan $chan]} {
			putserv "NOTICE $nick :\"$chan\": invalid chan."
			return 0
		}

		if { ![onchan $botnick $chan] } {
			putserv "NOTICE $nick :i'm not on the chan \"$chan\"."
			return 0
		}
		set msg [lrange [lindex $args 0] 1 end]
	}
	putchan $chan $msg
}


proc do_set_topic {nick ushost handle chan text} {

puthelp "topic $chan :$text"

  }

proc do_join_chan {nick uhost handle chan text} {

set 1chan [lindex [split $text] 0 ]

channel add  $1chan 

putserv "privmsg $chan :Successfully Joined $1chan"
}

proc do_remv_chan {nick uhost handle chan text} {

set 2chan [lindex [split $text] 0 ]

channel remove $2chan 

putserv "privmsg $chan : "Successfully Left $2chan"
}

proc pub:chanset {nick uhost hand chan arg} { 
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
set newnick [lindex [split $text] 0 ]
set nick $newnick
putserv "privmsg $chan :Successfully Changed My Nick To $newnick"
}

proc do_mode {nick uhost hand chan text} { 

set 2mode [lindex [split $text] 0 ]

putquick "mode $chan $2mode"

putserv "privmsg $chan :Successfully Set The Modes $2mode"

}

putlog "PubCMD.tcl Made By ComputerTech LOADED"
#################################################################################################################################################################

