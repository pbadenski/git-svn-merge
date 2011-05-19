#!/bin/zsh
autoload colors ; colors

SVN_REPO_DIR="`pwd`/svn-repository"

function setup_svn_repository
{
	git init
	svnadmin create svn-repository
	svn mkdir file:///$SVN_REPO_DIR/svn-project -m"Project"
	svn mkdir file:///$SVN_REPO_DIR/svn-project/trunk -m"Trunk"
	svn mkdir file:///$SVN_REPO_DIR/svn-project/branches -m"Branches"
	mkdir svn-trunk
	svn import svn-trunk -m"initial" file:///$SVN_REPO_DIR/svn-project/trunk
	svn co file:///$SVN_REPO_DIR/svn-project/trunk svn-trunk
	svn cp file:///$SVN_REPO_DIR/svn-project/trunk file:///$SVN_REPO_DIR/svn-project/branches/feature -m"Creating branch"
	svn co file:///$SVN_REPO_DIR/svn-project/branches/feature svn-feature
	touch svn-feature/alfa
	svn add svn-feature/alfa
	svn ci -m"Alfa" svn-feature
	svn merge file:///$SVN_REPO_DIR/svn-project/branches/feature svn-trunk
	svn ci svn-trunk -m"Merge alfa"
	svn cp file:///$SVN_REPO_DIR/svn-project/trunk file:///$SVN_REPO_DIR/svn-project/branches/feature_2 -m"Creating branch"
}

function assert_equals {
		if [ "$1" != "$2" ]; then
			echo "$fg[red]TEST FAILED !!! Should be equal."
			echo "$fg[green]Expected:$fg[white] $2"
			echo "$fg[red]Actual:$fg[white]   $1"
			exit
		else
			echo "$fg[green]TEST PASSED."
			echo "\t$fg[green]Expected:$fg[white] $2"
			echo "\t$fg[green]Actual:$fg[white]   $1"
		fi
}

function assert_contains {
		if [[ "$1" != *$2* ]]; then
			echo "$fg[red]TEST FAILED !!! Should contain."
			echo "$fg[green]Expected:$fg[white] $2"
			echo "$fg[red]Actual:$fg[white]   $1"
		else
			echo "$fg[green]TEST PASSED."
			echo "$fg[green]Expected:$fg[white] $2"
			echo "$fg[green]Actual:$fg[white]   $1"
		fi
}

