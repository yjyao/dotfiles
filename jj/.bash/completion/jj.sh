# Requires https://github.com/martinvonz/jj.
command -v jj &>/dev/null || exit

source <(jj util completion bash)

: ${FZF_JJ_REVSET_COMPLETION_TRIGGER:=@}

complete -o bashdefault -o default -F _fzf_complete_jj jj
complete -o bashdefault -o default -F _fzf_complete_jj j

_fzf_complete_jj() {
  local cur prev complete_type aliases
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  case $prev in
    -r|--revision|--revisions|-A|--insert-after|-B|--insert-before|--from|--to|--into|-s|--source|-d|--destination)
      complete_type='revs' ;;
    -b|--bookmark) complete_type='bookmarks' ;;
  esac
  [[ ! $complete_type ]] && case $cur in
    "${FZF_JJ_REVSET_COMPLETION_TRIGGER}" ) complete_type='revs'  ;;
    "${FZF_COMPLETION_TRIGGER:-**}"       ) complete_type='paths' ;;
  esac

  case $complete_type in

    paths)
      _fzf_path_completion
      ;;

    revs)
      local template_for_review=$(_jji config get templates.log)
      export LOG=$(_jji --color=always log -T "concat(
        '<cid>', raw_escape_sequence(if(divergent, commit_id.shortest(), change_id.shortest())), \"</cid>  \",
        $template_for_review
      )")

      FZF_COMPLETION_TRIGGER="$cur" _fzf_complete \
        -0 -1 \
        --no-sort \
        --exact \
        --tiebreak=begin \
        --multi \
        --read0 \
        --preview '
          echo "$LOG" |
            sed -E "
              s/^/  /
              s!^ (.*<cid>"{1}"</cid>)!>\1!
              s!<cid>.*</cid>\s*!!g
            "
          _jji --color=always show -s {1}
          ' \
        -- "$@" < <(
          echo "$LOG" |
            sed -En 's!.*<cid>(.*)</cid>.*!\1!p' |
            xargs -n1 -- bash -c '
              _jji --color=always log --no-graph -r "$1" -T "
                concat(
                  separate(
                    \" \",
                    pad_end(4, \"$1\"),
                    if(!mine, author.name()),
                    if(current_working_copy, label(\"working_copy\", \"@\")),
                    bookmarks,
                    tags,
                    description.first_line(),
                  ),
                  \"\0\",
                )"' _
          )
      ;;

    # bookmarks)
    #   FZF_COMPLETION_TRIGGER="$trigger" _fzf_complete \
    #     --preview 'jj log --color=always -r "immutable_heads()::{1}"' \
    #     -- "$@" < <(
    #       jj bookmark list -T 'name'
    #     )
    #   ;;

    *)
      _jj "$@"  # Generate jj's built-in `COMPREPLY`.

      # Suggest the aliases if the current line doesn't have a subcommand.
      # That's when the line before the cursor
      # contains exactly 1 non-option arguments: the jj command itself.
      (( $(_non_option_arguments "${COMP_WORDS[@]:0:COMP_CWORD}" | wc -l) == 1 )) &&
        COMPREPLY=("${COMPREPLY[@]}" $(_jj_aliases))

      if [[ ${#COMPREPLY[@]} = 0 ]]; then
        _fzf_path_completion
      else
        FZF_COMPLETION_TRIGGER= _fzf_complete \
          -0 -1 \
          --no-sort -- "$@" < <(
          for r in "${COMPREPLY[@]}"; do
            if [[ $r = "[FILESETS]..." ]]; then
              _jji log -r @ -T '' --no-graph --name-only
            else
              echo "$r"
            fi
          done
          echo "${aliases}"
        )
      fi
      ;;

  esac
}

_fzf_complete_jj_post() {
  input="$(cat | awk '{print $1}')"
  case $(echo "$input" | wc -l) in
    1 ) echo "$input"
      ;;
    2 ) echo "$input" | tac | awk '{printf "%s%s", sep, $0; sep="::"}'
      ;;
    * ) echo "$input" | tac | paste -sd'|' | xargs printf "'%s'"
      ;;
  esac
}

_jji() {
  jj --ignore-working-copy "$@"
}
export -f _jji

_jj_aliases() {
  _jji config list -T 'name ++ "\n"' 'aliases' | cut -d'.' -f2
}

_non_option_arguments() {
  printf '%s\0' "$@" | grep -vz -e '^-' | tr '\0' '\n'
}
