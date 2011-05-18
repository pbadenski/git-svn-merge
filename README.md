# Git SVN Merge
Licensed under GNU General Public License v2.

Merge support is based on cherry-picking and may not satisfy your needs - but it works.

# Instructions
If you're using Git 1.7.5:

 * replace old 'git-svn' script with this one

Otherwise:

 * use your favourite diff tool to apply changes (you may want to download original 'git-svn' and perform 3-way merge),
 * afterwards verify everything works fine by running "tests/test.sh"

Usage:

    git svn merge <list_of_git_commits>..

and afterwards

    git svn dcommit


If you receive an error continue with:

    git svn merge --continue

See bash test scripts to get more idea on how to use it and what's exactly going on. 

**THIS SOFTWARE IS STILL WORK IN PROGRESS AND WILL DAMAGE YOUR DATA!
USE WITH CAUTION!**

#Known limitations (vel bugs)
 * merge via more than 2 branches may not work properly for some corner cases (see tests),
 * errors may not be handled properly in some cases, if you get an error verify that all commits were merged properly,
 * there's no verification of whether certain commit was already merged,
 * there's no support for reverse merges (equivalent of 'git revert'),
 * there's no support for reintegrate,
 * renames may not be handled properly (consider using 'diff.renameLimit' set to 0)
