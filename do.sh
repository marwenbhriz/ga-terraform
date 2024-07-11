#!/bin/bash

# AUTOMATE SCRIPT FOR GA/TERRAFORM PROGRAMS
set -e

generate_cost_report() {
    REPORT_NAME=${REPORT_NAME:-$1}
    CURRENCY=${CURRENCY:-$2}

    if [[ -z ${REPORT_NAME} ]] || [[ -z ${CURRENCY} ]] ; then
        echo 'missing arguments'
        exit 1
    fi

    case $CURRENCY in
        USD)
            infracost configure set currency USD
            ;;
        JPY)
            infracost configure set currency JPY
            ;;
        EUR)
            infracost configure set currency EUR
            ;;
        *)
            echo 'allowed values for $CURRENCY: [USD|JPY|EUR]'
            exit 1
            ;;
    esac

    read -p "Do you want to generate the infrastructure cost estimation (Y/N)? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        infracost breakdown --path . --format html --show-skipped > ${REPORT_NAME}.html
    fi
}

audit_infra() {
    OUTPUT_TYPE=${OUTPUT_TYPE:-$1}

    if [[ -z ${OUTPUT_TYPE} ]] ; then
        echo 'missing argument'
        exit 1
    fi

    case $OUTPUT_TYPE in
        cli)
            read -p "Do you want start the infrastructure audit (Y/N)? " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                checkov -d ./ -o cli --output-file-path vulnerabilities
            fi
            ;;
        json)
            read -p "Do you want start the infrastructure audit (Y/N)? " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                checkov -d ./ -o json --output-file-path vulnerabilities
            fi
            ;;
        xml)
            read -p "Do you want start the infrastructure audit (Y/N)? " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                checkov -d ./ -o xml --output-file-path vulnerabilities
            fi
            ;;
        *)
            echo 'allowed values for $OUTPUT_TYPE: [cli|json|xml]'
            exit 1
            ;;
    esac
}

# Save infra plan configuration
plan() {
    terraform plan -out tfplan.plan
}

# Cleaning up infra
clean_up() {
    read -n1 -p "$(tput setaf 1)Do you want destroy the infrastructure and cleanup local terrafom files? (y/N): $(tput sgr0)" yn
    echo
    if [[ $yn != [yY] ]]; then
        echo "$(tput setaf 1)abort$(tput sgr0)"
        exit 1
    fi
    terraform plan -destroy -out=tfdestroy.destroy && terraform apply tfdestroy.destroy && rm -r ~/terraform/
}

generate_diagram() {
    TF_STATE=${TF_STATE:-$1}

    if [[ -z ${TF_STATE} ]] ; then
        echo 'missing arguments'
        exit 1
    fi

    read -n1 -p "$(tput setaf 1)Do you want genrate diagram of the infrastructure from the terrafom state file? (y/N): $(tput sgr0)" yn
    echo
    if [[ $yn != [yY] ]]; then
        echo "$(tput setaf 1)abort$(tput sgr0)"
        exit 1
    fi

    #inframap generate state.tfstate
    inframap generate state.tfstate | dot -Tpng > inframap_generate.png

}



$*
