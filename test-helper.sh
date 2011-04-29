SVN_REPO_DIR="home/pbadenski/git-svn-merge/svn-repository"

function setup_svn_repository
{
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
}
