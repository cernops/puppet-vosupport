# Functions for manipulating the grid environment
#
# gridpath_prepend - prepend a value to a path-like environmnet variable
#                                     - puts a ':' to the end end the beginning of the variable
#                                     - removes the value from the string and removes duplicate '::'
#                                     - prepend the value to the beginning of the variable
#                                     - removes duplicate '::' and removes ':' from the beginning and the end variable
#                                     - MANPATH has to be treated specially since, :: has a meaning -> don't get removed
#                                     - Simple : could have a meaning so if it was there in the end or the begining we should not remove it.
#                                     - export the variable, or echos the csh syntax
#
# gridpath_append - the same as prepend but it appends the value to the end of the variable
# gridpath_delete  - delete a value from an environment variable. if the value becomes null string then it unsets the environment variable
# gridemv_set     - sets an environment variable
# gridemv_unset   - unsets an environment variable
# gridenv_setind  - sets an environment variable if it is not already defined


function gridpath_prepend() {
		myvar="$1"
		myvalue="$2"
		myfieldsep=":"
		mytmp="`eval echo \\$$myvar`" 

                if [ "x$mytmp" = "x$myvalue" ] || [ "x$mytmp" = "x$myfieldsep$myvalue" ] || [ "x$mytmp" = "x$myvalue$myfieldsep" ] ; then
                   mytmp="${mytmp//$myvalue/}"
                else
                  mytmp="${mytmp//$myfieldsep$myvalue$myfieldsep/$myfieldsep}" 		#remove if in the middle
                  mytmp="${mytmp#$myvalue$myfieldsep}"					#remove if in the begining
                  mytmp="${mytmp%$myfieldsep$myvalue}"					#remove if at the end
                fi

                if [ "x$mytmp" = "x" ]; then
		  mytmp="$myvalue"
                else
		  mytmp="$myvalue$myfieldsep$mytmp"
                fi

                mytmp="${mytmp//$myfieldsep$myfieldsep$myfieldsep/$myfieldsep$myfieldsep}"

                if [ "x$myvar" = "xMANPATH" ] ; then
                  mytmp="${mytmp}::"
                fi
                if [ "x$ISCSHELL" = "xyes" ]; then
                  echo "setenv $myvar \"$mytmp\"" 
                fi
		  eval export ${myvar}=\""$mytmp"\"
} 

function gridpath_append() {
		myvar="$1"
		myvalue="$2"
		myfieldsep=":"
                mytmp="`eval echo \\$$myvar`"

                if [ "x$mytmp" = "x$myvalue" ] || [ "x$mytmp" = "x$myfieldsep$myvalue" ] || [ "x$mytmp" = "x$myvalue$myfieldsep" ] ; then
                   mytmp="${mytmp//$myvalue/}"
                else
                  mytmp="${mytmp//$myfieldsep$myvalue$myfieldsep/$myfieldsep}" 		#remove if in the middle
                  mytmp="${mytmp#$myvalue$myfieldsep}"					#remove if in the begining
                  mytmp="${mytmp%$myfieldsep$myvalue}"					#remove if at the end
                fi

		if [ "x$mytmp" = "x" ]; then 
                   mytmp="$myvalue"
                else
   		   mytmp="$mytmp$myfieldsep$myvalue"
                fi

                mytmp="${mytmp//$myfieldsep$myfieldsep$myfieldsep/$myfieldsep$myfieldsep}"

                if [ "x$myvar" = "xMANPATH" ] ; then
                  mytmp="${mytmp}::"
                fi
                if [ "x$ISCSHELL" = "xyes" ]; then
                  echo "setenv $myvar \"$mytmp\"" 
                fi
		  eval export ${myvar}=\""$mytmp"\"
} 

function gridenv_set() {
                myvar="$1"
                myvalue="$2"
                myfieldsep=":"

                if [ "x$ISCSHELL" = "xyes" ]; then
                  echo "setenv $myvar \"$myvalue\"" 
                fi
                  eval export ${myvar}="\"${myvalue}\""
}

function gridenv_setind() {
               myvar="$1"
               myvalue="$2"
               if [ "x$ISCSHELL" = "xyes" ]; then
	          echo 'if ( ${?'$myvar'} == 0 ) setenv '$myvar \'"$myvalue"\'
               fi
               eval "export $myvar=\${$myvar:-\$myvalue}"
}

function gridenv_unset() {
          	myvar="$1"
		eval unset \""$myvar"\"
}

function gridpath_delete() {
                myvar="${!1}"
		myvalue="$2"
		declare myvar=$(echo $myvar | sed -e "s;\(^$myvalue:\|:$myvalue$\|:$myvalue\(:\)\|^$myvalue$\);\2;g")
 
                 if [ "x$ISCSHELL" = "xyes" ]; then
                   echo "setenv $1 \"$myvar\"" 
                 fi
                 eval export $1=\""$myvar"\"
}

