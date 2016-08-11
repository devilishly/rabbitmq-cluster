if [ -z "$CLUSTERED" ]; then
    /usr/sbin/rabbitmq-server
else
    if [ -z "$CLUSTER_WITH" ]; then
        /usr/sbin/rabbitmq-server
    else
        /usr/sbin/rabbitmq-server -detached
        rabbitmqctl stop_app
        if [ -z "$RAM_NODE" ]; then
            rabbitmqctl join_cluster rabbit@$CLUSTER_WITH
        else
            rabbitmqctl join_cluster --ram rabbit@$CLUSTER_WITH
        fi
        rabbitmqctl start_app

	tail -f /var/log/rabbitmq/rabbit\@$HOSTNAME.log
    fi
fi
