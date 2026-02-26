# Calliope AI Kasm Image Build
#
# Usage: make build PRODUCT=chat VERSION=1.0.0
# Products: ide, lab, chat, loadr

PRODUCT := ide
REGISTRY := ghcr.io/calliopeai
KASM_VERSION := 1.17.0

# Product-specific image names and default versions
ifeq ($(PRODUCT),ide)
  IMAGE_NAME := calliope-ide-4kasm
  VERSION ?= 1.2.9
else ifeq ($(PRODUCT),lab)
  IMAGE_NAME := calliope-lab-4kasm
  VERSION ?= 1.2.5
else ifeq ($(PRODUCT),chat)
  IMAGE_NAME := calliope-chat-studio-kasm
  VERSION ?= 1.0.0
else ifeq ($(PRODUCT),loadr)
  IMAGE_NAME := calliope-loadr-kasm
  VERSION ?= 1.0.2
endif

DOCKERFILE := Dockerfile.$(PRODUCT)

# Tags
TAG_LATEST := $(REGISTRY)/$(IMAGE_NAME):latest
TAG_VERSION := $(REGISTRY)/$(IMAGE_NAME):$(VERSION)
TAG_DEV := $(IMAGE_NAME):dev

.PHONY: help build build-arm64 build-amd64 build-multi test push clean

help:
	@echo "Calliope AI Kasm Image Build"
	@echo ""
	@echo "Products: ide (default), lab, chat, loadr"
	@echo ""
	@echo "Usage:"
	@echo "  make build                    - Build for current platform (default: ide)"
	@echo "  make build PRODUCT=chat       - Build Chat Studio for current platform"
	@echo "  make build PRODUCT=loadr      - Build Loadr for current platform"
	@echo "  make build-arm64 PRODUCT=chat - Build for ARM64 only"
	@echo "  make build-amd64 PRODUCT=chat - Build for AMD64 only"
	@echo "  make build-multi PRODUCT=chat - Build multi-arch and push"
	@echo "  make test PRODUCT=chat        - Run image locally for testing"
	@echo "  make push                     - Push to registry"
	@echo "  make clean                    - Remove local images"

# Build for current platform (fast, for development)
build:
	docker build \
		--build-arg BASE_TAG=$(KASM_VERSION) \
		--build-arg CALLIOPE_VERSION=$(VERSION) \
		-f $(DOCKERFILE) \
		-t $(TAG_DEV) .

# Build for ARM64 only
build-arm64:
	docker buildx build \
		--platform linux/arm64 \
		--build-arg BASE_TAG=$(KASM_VERSION) \
		--build-arg CALLIOPE_VERSION=$(VERSION) \
		-f $(DOCKERFILE) \
		-t $(TAG_DEV)-arm64 \
		--load .

# Build for AMD64 only
build-amd64:
	docker buildx build \
		--platform linux/amd64 \
		--build-arg BASE_TAG=$(KASM_VERSION) \
		--build-arg CALLIOPE_VERSION=$(VERSION) \
		-f $(DOCKERFILE) \
		-t $(TAG_DEV)-amd64 \
		--load .

# Build multi-arch and push (requires docker login)
build-multi:
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--build-arg BASE_TAG=$(KASM_VERSION) \
		--build-arg CALLIOPE_VERSION=$(VERSION) \
		-f $(DOCKERFILE) \
		-t $(TAG_LATEST) \
		-t $(TAG_VERSION) \
		--push .

# Test the image locally
test: build
	@echo "Starting $(IMAGE_NAME) in Kasm..."
	@echo "Access at: https://localhost:6901"
	@echo "Username: kasm_user"
	@echo "Password: password"
	@echo ""
	docker run --rm -it \
		--shm-size=512m \
		-p 6901:6901 \
		-e VNC_PW=password \
		$(TAG_DEV)

# Push to registry
push:
	docker push $(TAG_LATEST)
	docker push $(TAG_VERSION)

# Clean up local images
clean:
	-docker rmi $(TAG_DEV) $(TAG_DEV)-arm64 $(TAG_DEV)-amd64 2>/dev/null
	-docker rmi $(TAG_LATEST) $(TAG_VERSION) 2>/dev/null
