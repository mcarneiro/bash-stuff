#!/bin/bash

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

if [[ -n "$YUIDIR" ]]; then
	_DOCDIR="-Djsdoc.dir=$YUIDIR"
	_BASEDIR="$YUIDIR"
else
	_DOCDIR=""
	_APPDIR="./app"
	_BASEDIR="."
fi

#default options
if [[ -z "`getArg "--line-break"`" ]]; then
	_lb="--line-break 500"
fi
if [[ -z "`getArg "-o"`" ]]; then
	_o="-o "`echo $1 | sed -E s/\.\(css\|js\)$/-min.\\\1/`
fi

_args=$@
CMD="java -jar $_BASEDIR/yuicompressor-2.4.7.jar $_args $_lb $_o -v"

echo '-----'
echo $CMD
echo '-----'
$CMD