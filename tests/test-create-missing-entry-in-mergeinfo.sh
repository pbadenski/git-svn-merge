#!/bin/zsh
source test-helper.sh

setup_svn_repository

git svn clone -T trunk -b branches file:///$SVN_REPO_DIR/svn-project git-svn-project

cd git-svn-project
	git co trunk
		touch beta
		git add beta
		git commit -m "Beta"
		git svn dcommit
		
	git co feature
		git svn merge `git rev-list --reverse trunk -1`
		git log -1
		git svn dcommit
		git svn propget svn:mergeinfo
		assert_equals "`git svn propget svn:mergeinfo`" "/svn-project/trunk:8"
cd ..

