#!/bin/sh
# ========================================
GITHUB_ACCOUNT=ElenaProkhorova
# files that aren't accessed in three days are deleted from /tmp
WS_DIR=/tmp/scriptworkspace1
REPO_NAME=Title_Validation_CSV
REPO_PATH=$WS_DIR/$REPO_NAME
MAIN=core.Selenium_csv
# ========================================

if which java >/dev/null 2>&1 ; then java -version &>jv.txt; grep "java version" jv.txt | awk '{print $1,$3}'; else echo Java not installed; exit -1; fi
if which mvn >/dev/null 2>&1 ; then mvn --version &>mv.txt; grep "Apache Maven" mv.txt | awk '{print $2,$3}'; else echo Maven not installed; exit -1; fi
if which git >/dev/null 2>&1 ; then git --version &>gv.txt; grep "git version" gv.txt | awk '{print $1,$3}'; else echo Git not instlled; exit -1; fi

if [ ! -d "$WS_DIR" ]
then mkdir -p "$WS_DIR"
fi

rm -rf "$REPO_PATH"

echo Using $WS_DIR as the Workspace

git clone https://github.com/$GITHUB_ACCOUNT/$REPO_NAME.git "$REPO_PATH"

mvn -f "$REPO_PATH" clean site package

echo "To see test report open $REPO_PATH/target/site/surefire-report.html"

echo "Executing Java program ..."
java -cp `find $REPO_PATH/target -name \*\.jar -print` $MAIN
# see report!!!
