#!/bin/sh
# Yêu cầu:
# - cài đặt helm trên máy local
# - cài đặt helm local chart version plugins bằng lệnh: 
#   - helm plugin install https://github.com/mbenabda/helm-local-chart-version
# Cách sử dụng:
# Chạy lệnh theo syntax sau: ./deploy.sh <tên thư mục>
# ví dụ:
# - ./deploy.sh xplat-ac-react

chart_name=$1

# tang version patch hien tai
#helm local-chart-version bump -s patch -c $chart_name

# lay version hien tai sau khi tang
echo "chart version: ${current_version}"
current_version=$(helm local-chart-version get -c $chart_name)

# dong goi package
echo "build package: ${chart_name}-${current_version}"
helm package $chart_name

# goi api
echo "deploy package: ${chart_name}-${current_version}.tgz"
curl -u <helm registry username>:<helm registry token> \
  -H 'accept: application/json' \
  -H 'Content-Type: multipart/form-data' \
  -F "helm.asset=@${chart_name}-${current_version}.tgz;type=application/gzip" \
  <Helm registry>
# Vi du:
# curl -u helm-push:aabbss1234XYZ \
#   -H 'accept: application/json' \
#   -H 'Content-Type: multipart/form-data' \
#   -F "helm.asset=@${chart_name}-${current_version}.tgz;type=application/gzip" \
#   https://some-helm-repository/service/rest/v1/components?repository=helms
  
