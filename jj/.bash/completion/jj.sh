# Requires https://github.com/martinvonz/jj.
command -v jj &>/dev/null || exit

source <(jj util completion bash)

: ${FZF_JJ_REVSET_COMPLETION_TRIGGER:=@}

_fzf_complete_jj() {
  local cur prev complete_type
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
      template_for_review=$(jj --ignore-working-copy config get templates.log)
      export LOG=$(jj --ignore-working-copy --color=always log -T "concat(
        '<cid>', if(divergent, commit_id.short(4), change_id.short(4)), '<cid> ',
        $template_for_review
      )")

      FZF_COMPLETION_TRIGGER="$cur" _fzf_complete \
        -0 -1 \
        --no-sort \
        --multi \
        --preview '
          echo "$LOG" |
            sed -E "
              s/^/  /
              s/^ (.*<cid>.*"{1}"\b.*<cid>)/>\1/
              s/<cid>.*<cid> //g
            "
          jj --ignore-working-copy --color=always show -s {1}
          ' \
        -- "$@" < <(echo "$LOG" | sed -En 's/.*<cid>(.*)<cid>/\1/p')
      ;;

    # bookmarks)
    #   FZF_COMPLETION_TRIGGER="$trigger" _fzf_complete \
    #     --preview 'jj log --color=always -r "immutable_heads()::{1}"' \
    #     -- "$@" < <(
    #       jj bookmark list -T 'name'
    #     )
    #   ;;

    *)
      _jj "$@"
      if [[ ${#COMPREPLY[@]} = 0 ]]; then
        _fzf_path_completion
      else
        FZF_COMPLETION_TRIGGER= _fzf_complete \
          -0 -1 \
          --no-sort -- "$@" < <(
          for r in "${COMPREPLY[@]}"; do
            if [[ $r = "[FILESETS]..." ]]; then
              jj --ignore-working-copy log -r @ -T '' --no-graph --name-only
            else
              echo "$r"
            fi
          done
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

complete -o bashdefault -o default -F _fzf_complete_jj jj
complete -o bashdefault -o default -F _fzf_complete_jj j
