bucket = press-start.mrkp.me

.PHONY: deploy build

build:
	@echo "===== building ====="
	@npm install
	@bundle exec middleman build

deploy: build
	@echo "===== deploying ====="
	@aws s3 sync build/ s3://$(bucket)/ --acl=public-read --delete --cache-control="max-age=1576800000" --exclude "*.html"
	@aws s3 sync build/ s3://$(bucket)/ --acl=public-read --delete --cache-control="max-age=0, no-cache" --exclude "*" --include "*.html"
