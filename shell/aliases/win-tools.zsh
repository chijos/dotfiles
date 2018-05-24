# BG_NICE tries to launch background processes with low priority
#  WSL does not seem to like this priority setting business, so need to disable 
#  the feature.
unsetopt BG_NICE

alias powershell="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
alias devenv="/mnt/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2017/Professional/Common7/IDE/devenv.exe"
alias ssms="/mnt/c/Program\ Files\ \(x86\)/Microsoft\ SQL\ Server/120/Tools/Binn/ManagementStudio/Ssms.exe"
alias msbuild="/mnt/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2017/Professional/MSBuild/15.0/Bin/MSBuild.exe"
alias ncrunch="/mnt/c/Program\ Files\ \(x86\)/Remco\ Software/NCrunch\ Console\ Tool/NCrunch.exe"
alias explorer="/mnt/c/Windows/explorer.exe &"
