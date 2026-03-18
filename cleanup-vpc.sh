#!/bin/bash
# cleanup-vpc-enhanced.sh

VPC_ID=$1
REGION="us-east-1"

echo "🧹 Enhanced cleanup for VPC: $VPC_ID"

# 1. Find and release EIPs associated with this VPC
echo "Checking for Elastic IPs..."
EIPS=$(aws ec2 describe-addresses --region $REGION --query 'Addresses[?NetworkInterfaceId!=`null`]' | jq -r '.[] | select(.NetworkInterfaceId | contains("eni")) | .AllocationId')
for eip in $EIPS; do
  echo "  Releasing EIP: $eip"
  aws ec2 release-address --region $REGION --allocation-id $eip
done

# 2. Delete NAT Gateways (already done but check)
echo "Checking NAT Gateways..."
NAT_GWS=$(aws ec2 describe-nat-gateways --region $REGION --filter "Name=vpc-id,Values=$VPC_ID" --query 'NatGateways[?State!=`deleted`].NatGatewayId' --output text)
for nat in $NAT_GWS; do
  echo "  Deleting NAT Gateway: $nat"
  aws ec2 delete-nat-gateway --region $REGION --nat-gateway-id $nat
done

# Wait for NAT gateways
if [ ! -z "$NAT_GWS" ]; then
  echo "Waiting 60s for NAT Gateways to delete..."
  sleep 60
fi

# 3. Find and delete network interfaces
echo "Checking Network Interfaces..."
ENIS=$(aws ec2 describe-network-interfaces --region $REGION --filters "Name=vpc-id,Values=$VPC_ID" --query 'NetworkInterfaces[?Status!=`in-use`].NetworkInterfaceId' --output text)
for eni in $ENIS; do
  echo "  Deleting Network Interface: $eni"
  aws ec2 delete-network-interface --region $REGION --network-interface-id $eni 2>/dev/null || echo "  Could not delete $eni (might be in use)"
done

# 4. Delete subnets
echo "Deleting Subnets..."
SUBNETS=$(aws ec2 describe-subnets --region $REGION --filters "Name=vpc-id,Values=$VPC_ID" --query 'Subnets[*].SubnetId' --output text)
for subnet in $SUBNETS; do
  echo "  Attempting to delete Subnet: $subnet"
  aws ec2 delete-subnet --region $REGION --subnet-id $subnet 2>/dev/null || echo "  Failed to delete $subnet, may still have dependencies"
done

# 5. Detach and delete Internet Gateways
echo "Deleting Internet Gateways..."
IGWS=$(aws ec2 describe-internet-gateways --region $REGION --filters "Name=attachment.vpc-id,Values=$VPC_ID" --query 'InternetGateways[*].InternetGatewayId' --output text)
for igw in $IGWS; do
  echo "  Detaching Internet Gateway: $igw"
  aws ec2 detach-internet-gateway --region $REGION --internet-gateway-id $igw --vpc-id $VPC_ID 2>/dev/null
  echo "  Deleting Internet Gateway: $igw"
  aws ec2 delete-internet-gateway --region $REGION --internet-gateway-id $igw 2>/dev/null
done

# 6. Delete Route Tables
echo "Deleting Route Tables..."
RTBS=$(aws ec2 describe-route-tables --region $REGION --filters "Name=vpc-id,Values=$VPC_ID" --query 'RouteTables[?Associations[?Main==`false`]].RouteTableId' --output text)
for rtb in $RTBS; do
  echo "  Deleting Route Table: $rtb"
  aws ec2 delete-route-table --region $REGION --route-table-id $rtb 2>/dev/null
done

# 7. Finally delete VPC
echo "Deleting VPC: $VPC_ID"
aws ec2 delete-vpc --region $REGION --vpc-id $VPC_ID

echo "✅ Enhanced cleanup complete for $VPC_ID"