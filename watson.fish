function __fish_watson_needs_sub -d "provides a list of sub commands"
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'watson' ]
    return 0
  end
  return 1
end

function __fish_watson_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 -a $cmd[1] = 'watson' ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
    return 1
  end
  return 1
end

function __fish_watson_get_projects
  command watson projects
end



complete -f -n '__fish_watson_needs_sub' -c watson -a cancel
complete -f -n '__fish_watson_needs_sub' -c watson -a config
complete -f -n '__fish_watson_needs_sub' -c watson -a edit
complete -f -n '__fish_watson_needs_sub' -c watson -a frames
complete -f -n '__fish_watson_needs_sub' -c watson -a help
complete -f -n '__fish_watson_needs_sub' -c watson -a log
complete -f -n '__fish_watson_needs_sub' -c watson -a merge
complete -f -n '__fish_watson_needs_sub' -c watson -a projects
complete -f -n '__fish_watson_needs_sub' -c watson -a remove
complete -f -n '__fish_watson_needs_sub' -c watson -a rename
complete -f -n '__fish_watson_needs_sub' -c watson -a report
complete -f -n '__fish_watson_needs_sub' -c watson -a restart

#start
complete -f -c watson -n '__fish_watson_needs_sub' -a start
complete -f -c watson -n '__fish_watson_using_command start' -a "(__fish_watson_get_projects)"

complete -f -n '__fish_watson_needs_sub' -c watson -a status
complete -f -n '__fish_watson_needs_sub' -c watson -a stop
complete -f -n '__fish_watson_needs_sub' -c watson -a sync
complete -f -n '__fish_watson_needs_sub' -c watson -a tags
