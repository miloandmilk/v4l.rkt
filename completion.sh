_v4l-rkt ()
{
    local ENDPOINTS='/linode/instances /linode/instances/ /linode/kernels /linode/distributions
                     /linode/types /linode/stackscripts \
                     /dns/zones \
                     /account/events /datacenters \
                     /networking/ipv4 /networking/ipv6 /networking/ip-assign'
    local INSTANCE_ENDPOINTS='/disks /configs /boot /shutdown /reboot /backups /backups/enable /backups/cancel /ips /rebuild'
    local cur

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    case "$cur" in
        /linode/instances/)
            IDS=$(v4l.rkt /linode/instances | jq -r '.linodes | map(("/linode/instances/" + (.id | tostring)) + "/") | join(" ")')
            COMPREPLY=( $( compgen -W "$IDS" -- $cur ) )
            ;;
        /linode/instances/*/)
            COMPREPLY=( $( compgen -W "$INSTANCE_ENDPOINTS" -- $cur ) )
            ;;
        /linode/instances/*)
            IDS=$(v4l.rkt /linode/instances | jq -r '.linodes | map(("/linode/instances/" + (.id | tostring)) + "/") | join(" ")')
            COMPREPLY=( $( compgen -W "$IDS" -- $cur ) )
            ;;
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
