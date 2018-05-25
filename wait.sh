#!/bin/bash

VERSION="1.0.0"

ROLE_NAME=DeployRole
PROFILE_NAME=deploy-profile

while test $# -gt 0
do
case $1 in

# Normal option processing
    -h | --help)
    echo "Usage:" >&2
    echo "wait [-h|--help] [-v|--version] -a|--account <aws account number> [-r|--role <IAM role>] [-p|--profile <aws cli profile name>] []" >&2
    echo "" >&2
    echo " Wait a role in the specified AWS account and creates temporary credentials in the named profile." >&2
    echo "   -h|--help      prints this help" >&2
    echo "   -v|--version   prints the current version of this script" >&2
    echo "   -a|--account   the AWS account number to deploy to. (mandatory)" >&2
    echo "   -r|--role      the IAM role to assume (defaults to DeployRole)" >&2
    echo "   -p|--profile   the name of the resulting aws cli profile to use (defaults to deploy-profile)" >&2
    echo "" >&2
    exit 0
    ;;
    -v | --version)
    echo "wait version $VERSION" >&2
    exit 0
    ;;
    -a | --account)
    AWS_ACCOUNT_NO=$2
    shift
    ;;
    -r | --role)
    ROLE_NAME=$2
    shift
    ;;
    -p | --profile)
    PROFILE_NAME=$2
    shift
    ;;
# ...

# Special cases
    --)
    break
    ;;
    --*)
    echo "Invalid option: $1" >&2
    # error unknown (long) option $1
    ;;
    -?)
    echo "Invalid option: $1" >&2
    # error unknown (short) option $1
    ;;

# FUN STUFF HERE:
# Split apart combined short options
    -*)
    split=$1
    shift
    set -- $(echo "$split" | cut -c 2- | sed 's/./-& /g') "$@"
    continue
    ;;

# Done with options
    *)
    break
    ;;
esac

shift
done

if [ -z "$AWS_ACCOUNT_NO" ]; then
    echo "account must not be specified"
    exit 1
fi

echo "Heeeeloooo"