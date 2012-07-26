# bash-stuff

Some of these scripts are not finished but most of them I use for a while with comercial projects.

## Stable scripts

- css/
	- css-base64
	- css-sprite*
- svn/
	- svn-ignore-add*
	- svn-psi*
	- svn-rev*
	- svn-url*
	- zip-by-log*
	- zip-by-st*
- util/
	- encodeme
	- getip*

\* Help option available via `?` argument. Ex.: `svn-url ?`

## Roadmap

1. Create documentation and help option for all scripts;

## Instalation

I tested these scripts on a Mac and some on Git-bash.

Place the desired scripts on a folder (Ex.: ~/bin/) and concatenate it to the PATH variable on yout `~/.bash_profile` file:

    export PATH="${PATH}:~/bin"

Give executable permission on the folder:

    chmod -R +x ~/bin