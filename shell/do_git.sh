#!/bin/bash  
########################################### 
#./do push <help> 
########################################### 
#https://github.com/1424234500/help_note.git        -> E:/ help_note    
#https://github.com/1424234500/base.git         -> E:/ workspqce_my/ * 
#https://github.com/1424234500/BaseSSM.git
#https://github.com/1424234500/cc.git
#https://github.com/1424234500/GraphicsTools.git 
#批量 github 添加 提交 推送的操作  
source constant.sh 
source tools.sh 
source do_clean.sh 

#_root='/mnt/e'
#_shell=$_root"/help_note/shell"

echo 'Git log file: '$git_log
 
git config --global user.name 'Walker'  
git config --global user.email '1424234500@qq.com'  
# git config --global core.autocrlf input #提交转换unix
git config --global core.safecrlf true #拒绝混合lrlf

# echo 'http://1424234500%40qq.com:qwer301415926@github.com' > ~/.git-credentials  #保存配置
# git config --global credential.helper store #设置文件认证

function commit(){
    git_exefun 'git_add_commit' $1 
} 
function push(){ 
    toolsLineLong
    # clean python 
#    clean_clean 
    toolsLineLong
    rm '/home/walker/e/workspace/walker/${sys:LOG_PATH}' -r
    
#    git_exefun 'git_add_commit_push' $1
    do_project_exefun 'git_add_commit_push' $1
}
function update(){ 
#    git_exefun 'git_add_commit_pull' $1 
    do_project_exefun 'git_add_commit_pull' $1 
} 
function git_add_commit_pull(){
    echo 'update add/commt/pull: '$1
    cd $1
    toolsLineLong >> $git_log
    pwd >> $git_log
    git add . >> $git_log
    git commit -am "`date`" >> $git_log
    git pull origin master >> $git_log
    toolsLineLong >> $git_log 
}
function git_add_commit_push(){
    echo 'upload clean/add/commit/push: '$1
    # clean java bin build
    # clean_cleanJavaProject $1

    cd $1
    toolsLineLong >> $git_log
    pwd >> $git_log
    git add . >> $git_log
    git commit -am "`date`" >> $git_log
    git push -u origin master >> $git_log
    toolsLineLong >> $git_log 
}

function git_add_commit(){
    echo 'commit add/commt: '$1
    cd $1
    toolsLineLong >> $git_log
    pwd >> $git_log
    git add . >> $git_log
    git commit -am "`date`" >> $git_log
    toolsLineLong >> $git_log
}

function git_clone(){

    # git_remote_urls
    # git_local_dirs 

    len=${#git_remote_urls[@]}
    for ((i=0; i<$len; i++))
    do
        remoteUrl=${git_remote_urls[$i]}
        localDir=${git_local_dirs[$i]}
		localDirParent=${localDir%/*}
		[ ! -d ${localDirParent} ] && mkdir -p ${localDirParent}
		echo "${localDirParent} <- ${localDir} <- ${remoteUrl} "
		
		if [ -d ${localDir} ];then
			echo "${localDir} have exists 已存在 "
		else
			echo "开始 begin clone"
			cd $localDirParent
			echo 'git clone '$remoteUrl
			echo 'git clone '$remoteUrl >> $git_log
			git clone $remoteUrl
		fi
    done

}




function start_main(){ 
    echo
    toolsShow $@
    ##########################do something yourself
    do_init $@
    ##########################
    toolsLineLong 
    echo
}

function do_init(){  
    method=$1
    if [[ "$method" != "" ]]
    then 
        rootParams=($@)   
        params=(${rootParams[@]:1}) 
        toolsShowMethod $method "${params[*]}"
        #echo ${params[@]}
        $method ${params[@]}
    else
        echo 'eg:'
        echo './do test "params of test"'
    fi
}





# 单独执行文件时操作如下 引入时提示
_temp='do_git.sh'
if [[ $0 =~ $_temp ]]
then
    start_main $@
else
    echo 'source '$_temp
fi 



