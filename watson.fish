# copy this into ~/.config/fish/completions/ to enable autocomplete for the watson time tracker
#
function __fish_watson_needs_sub -d "provides a list of sub commands"
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'watson' ]
    return 0
  end
  return 1
end

function __fish_watson_using_command -d "determine if watson is using the passed command"
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 2 -a $cmd[1] = 'watson' ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
    return 1
  end
  return 1
end

function __fish_watson_get_projects -d "return a list of projects"
  command watson projects
end

function __fish_watson_get_tags -d "return a list of tags"
  command watson tags
end

function __fish_watson_has_project -d "determine if watson is using a passed command and if it has a project"
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 2 -a $cmd[1] = 'watson' ]
    if [ $argv[1] = $cmd[2] ]
      if contains "$cmd[3]" (__fish_watson_get_projects)
        return 0
      end
    end
  end
  return 1
end

function __fish_watson_get_frames -d "return a list of frames" #TODO, use watson logs to get more info
  command watson frames
end

# if a backend.url is set, use it in the command description
if [ -e ~/.config/watson/config ]
  set url_string (command watson config backend.url 2> /dev/null)
  if test -n "$url_string"
    set url $url_string
  end
else
  set url "a remote Crick server"
end

complete -f -c watson -n '__fish_watson_needs_sub' -a cancel -d "Cancel the last start command"
complete -f -c watson -n '__fish_watson_needs_sub' -a config -d "Get and set configuration options"
complete -f -c watson -n '__fish_watson_needs_sub' -a report -d "Display a report of time spent"
complete -f -c watson -n '__fish_watson_needs_sub' -a restart -d "Restart monitoring time for a stopped project"
complete -f -c watson -n '__fish_watson_needs_sub' -a status -d "Display when the current project was started and time spent"
complete -f -c watson -n '__fish_watson_needs_sub' -a stop -d " Stop monitoring time for the current project"
complete -f -c watson -n '__fish_watson_needs_sub' -a frames -d "Display the list of all frame IDs"
complete -f -c watson -n '__fish_watson_needs_sub' -a help -d "Display help information"
complete -f -c watson -n '__fish_watson_needs_sub' -a log -d "Display sessions during the given timespan"
complete -f -c watson -n '__fish_watson_needs_sub' -a merge -d "merge existing frames with conflicting ones"
complete -f -c watson -n '__fish_watson_needs_sub' -a projects -d "Display the list of projects"
complete -f -c watson -n '__fish_watson_needs_sub' -a tags -d "Display the list of tags"
complete -f -c watson -n '__fish_watson_needs_sub' -a sync -d "sync your work with $url"

#edit
complete -f -c watson -n '__fish_watson_needs_sub' -a edit -d "Edit a frame"
complete -f -c watson -n '__fish_watson_using_command edit' -a "(__fish_watson_get_frames)"

#remove
complete -f -c watson -n '__fish_watson_needs_sub' -a remove -d "Remove a frame"
complete -f -c watson -n '__fish_watson_using_command remove' -a "(__fish_watson_get_frames)"

#rename
complete -f -c watson -n '__fish_watson_needs_sub' -a rename -d "Rename a project or tag"
complete -f -c watson -n '__fish_watson_using_command rename' -a "(__fish_watson_get_projects) (__fish_watson_get_tags)"

#start
complete -f -c watson -n '__fish_watson_needs_sub' -a start -d "Start monitoring time for a project"
complete -f -c watson -n '__fish_watson_using_command start' -a "(__fish_watson_get_projects)"
complete -f -c watson -n '__fish_watson_has_project start' -a "+(__fish_watson_get_tags)"
