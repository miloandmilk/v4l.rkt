_v4l-rkt ()
{
    local ENDPOINTS='/linode/instances /linode/kernels /linode/distributions
                     /linode/types /linode/stackscripts \
                     /dns/zones \
                     /account/events /datacenters \
                     /networking/ipv4 /networking/ipv6 /networking/ip-assign'
    local cur

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    case "$cur" in
        /*)
            COMPREPLY=( $( compgen -W "$ENDPOINTS" -- $cur ) )
            ;;
    esac
}

if [[ "$SHELL" == *"zsh"* ]]
then
    autoload -U +X compinit && compinit
    autoload -U +X bashcompinit && bashcompinit
fi

complete -F _v4l-rkt -o display v4l.rkt
