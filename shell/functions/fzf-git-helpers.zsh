#!/bin/zsh

is_inside_git_repo() {
	git rev-parse HEAD > /dev/null 2>&1
}

fzb() {
	is_inside_git_repo || return

	# define two local variables
	local branches branch

	# set branches to the output of "git branch -a"
	branches=$(git branch -a) &&

	# allow user to interactively select a branch from that
	branch=$(echo "$branches" \
		| fzf --no-sort --no-multi --exact --preview-window right:70% \
			--preview 'git log --color --pretty=format:"%C(yellow)%h%Creset %s %Cgreen(%cr)%Creset %C(bold blue)<%an>%Creset" origin/master..$(sed "s/\s.*$/\0/" <<< {})') && # the 'sed' bit trims the leading space from the result

	# checkout the selected branch (trim the "remotes/origin/" prefix if a remote branch is selected)
	git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")	
}

fzc() {
	is_inside_git_repo || return

	# define two local variables
	local hashAndMessageList selectedHash
	
	# set hashAndMessageList to the output of "git log"
	hashAndMessageList=$(git log --all --pretty=format:"%h %s (%cr)") &&

	# allow user to interactively select a hash from that
	selectedHash=$(echo "$hashAndMessageList" \
		| fzf --no-sort --no-multi --exact --preview-window right:70% --preview 'git show --color=always $(sed "s/\s.*$//" <<< {})' \
	        | sed 's/\s.*$//') && # trim everything but commit hash

	# checkout the selected hash
    git checkout $(echo "$selectedHash")
}

fzs() {
    # define local variable
    local solutionFilePath

    # allow user to interactively select solution file
    solutionFilePath=$(fzf --query=".sln$ ") &&

    # log the selected solution file
    echo "Launching $solutionFilePath" &&
    
    # open the selected solution file
    devenv $(echo "$solutionFilePath") > /dev/null 2>&1 &
}

fzsql() {
    # define local variable
    local sqlFilePaths

    # allow user to interactively select solution file
    IFS=$'\n' sqlFilePaths=($(fzf --query=".sql$" --multi)) &&
    
    [[ -n "$sqlFilePaths" ]] &&
    
    # open the selected solution file
    ssms $(echo "${sqlFilePaths[@]}") > /dev/null 2>&1 &
}

fzlog() {
    # define local variables
    local fileItems fileItem logFileFullName logName

    # grab all the log file paths in the directory
    fileItems=$(ls -ctRl --color=never | awk '{print $6, $7, $8, $9}') &&

	# allow user to interactively select a branch from that
	fileItem=$(echo "$fileItems" \
		| fzf --no-sort --no-multi --exact --preview-window bottom:60% \
        --preview 'tail -n 20 $(awk "{print \$4}" <<< {})') &&

    # grab a name for the log file to use for labelling the tmux pane
    logFileFullName=$(echo $fileItem | awk '{print $4}') &&
    logName="${${${${logFileFullName/Orbis./}/OPS./}/.log/}/.txt/}"

    # start tailing file
    if [ "$TERM" = "tmux-256color" ] && [ -n "$TMUX" ]; then
        tmux new-window -n $logName "tail ---disable-inotify -f $logFileFullName"
    else
        # log the file name that was selected
        tput setaf 1 && # change output color
        echo "TAILING: $logFileFullName" &&
        tput sgr0 && # reset output color
        
        tail -f $logFileFullName
    fi
}
