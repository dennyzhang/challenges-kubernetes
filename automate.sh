#!/bin/bash -e
function refresh_wordpress() {
    local max_days=${MAX_DAYS:-"7"}
    echo "Use emacs to update README.org"
    for f in $(find . -name 'README.org' -mtime -${max_days} | grep -v '^README.org$'); do
        echo "Update $f"
        dirname=$(basename $(dirname $f))
        cd $dirname
        /Applications/Emacs.app/Contents/MacOS/Emacs-x86_64-10_10 --batch -l ../emacs-update.el
        cd ..
    done
}

function git_push() {
    for d in $(ls -1); do
        if [ -d "$d" ] && [ -f "$d/.git" ]; then
            cd "$d"
            echo "In ${d}, git commit and push"
            git add *.org
            git commit --amend --no-edit
            git push origin master --force
            cd ..
        fi
    done
    git commit -am "update doc"
    git push origin
}

function git_pull() {
    for d in $(ls -1); do
        if [ -d "$d" ] && [ -f "$d/.git" ] ; then
            cd "$d"
            echo "In ${d}, git pull"
            git pull origin
            cd ..
        fi
    done
    git pull origin
}

function refresh_link() {
    echo "refresh link"
    cd problems
    for f in $(ls -1t */README.org); do
        dirname=$(basename $(dirname $f))
        if ! grep "Blog link: https:\/\/code.dennyzhang.com.*$dirname" $f 1>/dev/null 2>&1; then
            echo "Update blog url for $f"
            sed -ie "s/Blog link: https:\/\/code.dennyzhang.com\/.*/Blog link: https:\/\/code.dennyzhang.com\/$dirname/g" $f
            rm -rf $dirname/README.orge
        fi

        if ! grep "tree\/master.*$dirname" $f 1>/dev/null 2>&1; then
            echo "Update GitHub url for $f"
            sed -ie "s/tree\/master\/.*/tree\/master\/$dirname][challenges-leetcode-interesting]]/g" $f
            rm -rf $dirname/README.orge
        fi

        if ! grep -i lintcode.com $f 1>/dev/null 2>&1; then
            if ! grep "leetcode.com.*$dirname" $f 1>/dev/null 2>&1; then
                echo "Update Leetcode url for $f"            
                sed -ie "s/https:\/\/leetcode.com\/problems\/.*/https:\/\/leetcode.com\/problems\/$dirname\/description\/][leetcode.com]]/g" $f
                rm -rf $dirname/README.orge
            fi
        fi
    done
}

cd .

action=${1?}
eval "$action"
