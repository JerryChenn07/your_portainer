if [[ $1 ]]; then
  stack_name=$1
else
  stack_name="your-portainer"
fi

echo "stack name: "${stack_name}

docker stack deploy ${stack_name} --prune -c portainer-agent-stack.yml
