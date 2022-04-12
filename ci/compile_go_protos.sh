#!/bin/bash
#
# Copyright the Hyperledger Fabric contributors. All rights reserved.
#
# SPDX-License-Identifier: Apache-2.0

set -eu -o pipefail

repo="build/fabric-protos-go"

if [ ! -d "$repo" ]; then
  echo "$repo does not exist"
  exit 1
fi

for protos in $(find . -name '*.proto' -exec dirname {} \; | sort -u); do
  protoc --go_out=$repo --go_opt=paths=source_relative --go-grpc_out=require_unimplemented_servers=false:$repo --go-grpc_opt=paths=source_relative "$protos"/*.proto
done

