#!/bin/bash



# Platform Information
echo "=== Platform Information ==="
uname -a

#cat /proc/version
#cat /etc/redhat-release
echo ""


# CPU Information
echo "=== CPU Information ==="
lscpu
echo ""


# RAM Information
echo "=== RAM Information ==="
free -h
echo ""


# GPU Information
echo "=== GPU Information ==="

# Check if the command 'nvidia-smi' is available for NVIDIA GPUs
if command -v nvidia-smi &>/dev/null; then
    nvidia-smi
else
    echo "NVIDIA GPU info tool (nvidia-smi) not found. Checking for alternative GPU info..."

    # For systems with integrated graphics or other than NVIDIA GPUs
    lspci | grep VGA
fi


echo "==========================="
