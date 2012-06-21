#!/bin/bash

# launcher script for jsdoc
# Author: Avi Deitcher
# Copyright (c) 2008-2009 Atomic Inc <avi@jsorm.com>

# Customização dos parâmetros do comando (diretório de destino agora é opcional e customizável via parâmetro)


ARGS=( "$@" );
getArg() {
	local CURRARG=""
	local HASDASH=""
	local GETNEXTVALUE=""
	local a=""

	HASDASH=`echo $1 | awk -F "^-+" '{print$2}'`
	if [[ -n "$HASDASH" ]]; then
		
		for(( i=0; i<${#ARGS[@]}; i++ )); do
			a=${ARGS[$i]}
			if [ "$a" == "$1" ]; then
				GETNEXTVALUE="1"
				continue;
			fi
			if [[ "$GETNEXTVALUE" == "1" ]]; then
				CURRARG=$a
				break;
			fi
		done
		
	else
		for(( i=0; i<${#ARGS[@]}; i++ )); do
			a=${ARGS[$i]}
			CURRARG=`echo $a | awk -F "$1=" '{print$2}'`
			if [ "$CURRARG" != "" ]; then
				break;
			fi
		done
	fi
	echo $CURRARG
}

if [[ -n "$JSDOCDIR" ]]; then
	_DOCDIR="-Djsdoc.dir=$JSDOCDIR"
	_APPDIR="$JSDOCDIR/app"
	_BASEDIR="$JSDOCDIR"
else
	_DOCDIR=""
	_APPDIR="./app"
	_BASEDIR="."
fi

if [[ -n "$JSDOCTEMPLATEDIR" ]]; then
	_TDIR="-t=$JSDOCTEMPLATEDIR"
else
	_TDIR="-t=$_BASEDIR/templates/jsdoc"
fi

_d="-d=./jsdoc"
_args="$@"
if [[ -n "`getArg "-d"`" ]]; then
	_d=""
fi

CMD="java $_DOCDIR -jar $_BASEDIR/jsrun.jar $_APPDIR/run.js $_args $_TDIR $_d"
echo '-----'
echo $CMD
echo '-----'
$CMD

