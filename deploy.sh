#!/bin/bash
docker build -t kutkin/sample-node .
docker push kutkin/sample-node

ssh deploy@46.101.185.35 << EOF
docker pull kutkin/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi kutkin/sample-node:current || true
docker tag kutkin/sample-node:latest kutkin/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 kutkin/sample-node:current
EOF
