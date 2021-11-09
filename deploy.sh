#!/bin/bash
source .env

################################################################################
# Help                                                                         #
################################################################################
help()
{
    # Display Help
    echo "Usage: deploy.sh [ACTION]"
    echo "Deploy dockers"
    echo
    echo "actions:"
    echo "up                  Deploy containers."
    echo "down                Stop and remove containers."
    echo "status              Show containers status."
    echo "test                Test reversy proxy with whami service."
    echo
}

deploy_up()
{
    # Create network if not exists
    docker network inspect reverse-public >/dev/null 2>&1 || \
        docker create network reverse-public 

    echo "start services"
    docker-compose up -d
}

deploy_down()
{
    docker-compose down
}

deploy_status()
{
    docker-compose ps
}

deploy_test()
{
    docker-compose -f whoami-docker-compose.yml up
}

################################################################################
################################################################################
# Main program                                                                 #
################################################################################


if [ "$#" != "1" ]
then
    help
    exit
fi

case $1 in
    up)
        deploy_up
        ;;
    down)
        deploy_down
        ;;
    status)
        deploy_status
        ;;
    test)
        deploy_test
        ;;
    *)
        help
        ;;
esac
