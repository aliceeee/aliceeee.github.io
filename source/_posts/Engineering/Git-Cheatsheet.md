---
title: Git Cheatsheet
date: 2019-04-11 16:11:48
tags:
    git
    cheatsheet
categories:  
    Tech
    
---


> See [Official Manual](https://git-scm.com/docs)


# 信息查看

## Branch
```
git symbolic-ref --short HEAD
git rev-parse --abbrev-ref HEAD
```

<!-- more -->

# Clone

```
git clone xxx
git clone xxx --depth=1
```


# Commit

## 回退commit

```
# 保留修改
git reset HEAD~1 --soft

# 不保留本地修改，！危险！
git reset HEAD~1 --hard
```

## 回退git add（从暂存区删除）
```
git reset HEAD --
git reset HEAD -<directoryName>
```


## 设置本地文件不提交到远程(例如本地的.project等)
```
$ git update-index --assume-unchanged /path/to/file       #忽略跟踪
$ git update-index --no-assume-unchanged /path/to/file  #恢复跟踪
```
查看忽略跟踪的文件
```
git ls-files -v | grep "^[[:lower:]]"
```

## Git合并两次commit为一个commit

https://stackoverflow.com/questions/2563632/how-can-i-merge-two-commits-into-one
```
$ git log --pretty=oneline
a931ac7c808e2471b22b5bd20f0cad046b1c5d0d c
b76d157d507e819d7511132bdb5a80dd421d854f b
df239176e1a2ffac927d8b496ea00d5488481db5 a

$ git rebase --interactive HEAD~2
```
出现编辑
```
pick b76d157 b
pick a931ac7 c

# Rebase df23917..a931ac7 onto df23917
#
# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
#
```
改为
```
pick b76d157 b
squash a931ac7 c
```
保存后修改comment即可

## Git修改上一次commit人
> https://www.jianshu.com/p/7def4f387e9f

修改最近一次
```sh
git commit --amend --author="userName <userEmail>"
```

批量修改
```sh
git filter-branch --env-filter '
if [ "$GIT_AUTHOR_NAME" = "oldName" ]
then
export GIT_AUTHOR_NAME="newName"
export GIT_AUTHOR_EMAIL="newEmail"
fi
' ref..HEAD

git filter-branch --env-filter '
if [ "$GIT_COMMITTER_NAME" = "oldName" ]
then
export GIT_COMMITTER_NAME="newName"
export GIT_COMMITTER_EMAIL="newEmail"
fi
' ref..HEAD
```


# Git gc
控制git repo大小
```
git gc
```


# Patch
Git create/apply patch
```
# 标准patch
git diff master > patch
git apply patch

# git专用patch
git format-patch -M master
git am 0001-Fix1.patch
```

# Git clean

https://git-scm.com/docs/git-clean

```
// 一次clean的演习
git clean -n

// 删除当前目录下所有没有track过的文件. 他不会删除.gitignore文件里面指定的文件夹和文件, 不管这些文件有没有被track过.
git clean -f

// 删除指定路径下的没有被track过的文件
git clean -f <path>

// 删除当前目录下没有被track过的文件和文件夹.
git clean -df

// 删除当前目录下所有没有track过的文件. 不管他是否是.gitignore文件里面指定的文件夹和文件
git clean -xf

git reset --hard和git clean -f是一对好基友. 结合使用他们能让你的工作目录完全回退到最近一次commit的时候.

git clean对于刚编译过的项目也非常有用. 如, 他能轻易删除掉编译后生成的.o和.exe等文件. 这个在打包要发布一个release的时候非常有用.
```

# Git merge
https://git-scm.com/docs/git-merge

```sh
git checkout master
git merge dev              # =--ff，即fast-forward，当merge是fast-forward时，只更新指针（如果删除分支，则会丢失分支信息）

git merge --no-ff         #  即使fast-forward也创建 merge commit

git merge --squash      # 使用squash方式合并，把多次分支commit历史压缩为一次
```
--squash：是用来把一些不必要commit进行压缩，比如说，你的feature在开发的时候写的commit很乱，那么我们合并的时候不希望把这些历史commit带过来，于是使用--squash进行合并，此时文件已经同合并后一样了，但不移动HEAD，不提交。需要进行一次额外的commit来“总结”一下，然后完成最终的合并。


Git去掉某个merge
https://segmentfault.com/q/1010000000140446
https://git-scm.com/blog/2010/03/02/undoing-merges.html
http://schacon.github.io/git/git-revert.html

```
git revert -m 1 00519a
```



