#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INVENTORY_FILE="$SCRIPT_DIR/host.ini"
ANSIBLE_DIR="$SCRIPT_DIR/ansible"

cmd_ansible() {
    echo "=== Running Ansible ==="

    # Check for playbook
    if [ -f "$SCRIPT_DIR/playbook.yml" ]; then
        echo "Running playbook.yml..."
        ansible-playbook -i "$INVENTORY_FILE" "$SCRIPT_DIR/playbook.yml"
    elif [ -f "$ANSIBLE_DIR/tasks/main.yml" ]; then
        echo "Running ansible/tasks/main.yml..."
        ansible-playbook -i "$INVENTORY_FILE" -m import_tasks "$ANSIBLE_DIR/tasks/main.yml" all
    else
        echo "No playbook found. Checked locations:"
        echo "  - $SCRIPT_DIR/playbook.yml"
        echo "  - $ANSIBLE_DIR/tasks/main.yml"
        echo ""
        echo "Create a playbook to run Ansible tasks."
        exit 1
    fi
}

cmd_ping() {
    echo "=== Testing Connection to Hosts ==="
    ansible all -i "$INVENTORY_FILE" -m ping
}

cmd_facts() {
    echo "=== Gathering Facts from Hosts ==="
    ansible all -i "$INVENTORY_FILE" -m setup
}

cmd_update() {
    echo "=== Updating System Packages ==="
    if [ -f "$SCRIPT_DIR/update.yml" ]; then
        echo "Running update.yml..."
        ansible-playbook -i "$INVENTORY_FILE" "$SCRIPT_DIR/update.yml"
    else
        echo "update.yml not found."
        exit 1
    fi
}

show_help() {
    cat << EOF
Ansible Runner Script

USAGE:
    $0 <command>

COMMANDS:
    ansible     - Run Ansible playbook (default)
    ping        - Test connection to all hosts
    facts       - Gather facts from all hosts
    update      - Update system packages on all hosts
    help        - Show this help message

EXAMPLES:
    $0 ansible
    $0 ping
    $0 facts
    $0 update

EOF
}

main() {
    COMMAND=${1:-ansible}

    case "$COMMAND" in
        ansible)
            cmd_ansible
            ;;
        ping)
            cmd_ping
            ;;
        facts)
            cmd_facts
            ;;
        update)
            cmd_update
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            echo "Unknown command: $COMMAND"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

main "$@"

