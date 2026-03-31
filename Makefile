SHELL := /bin/bash

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

DOCKER_COMPOSE_FILES := -f docker-compose.yml

DATA_DIR ?= $(MKFILE_DIR)/data/
ASSETS_DIR ?= $(MKFILE_DIR)/assets/
APPROACHES_DIR := $(MKFILE_DIR)/approaches/

PARAMETERS := MKFILE_DIR=$(MKFILE_DIR) \
              DATA_DIR=$(DATA_DIR) \
              ASSETS_DIR=$(ASSETS_DIR) \
              APPROACHES_DIR=$(APPROACHES_DIR)

prepare-terminal-for-visualization:
	xhost +local:docker

####################
# MAST3R-SLAM
####################
MAST3R_SLAM_ROOT_DIR := $(APPROACHES_DIR)/mast3r_slam/

build-mast3r_slam:
	cd $(MKFILE_DIR) && \
	$(PARAMETERS) \
	ROOT_DIR=$(MAST3R_SLAM_ROOT_DIR) \
	docker compose build mast3r_slam

run-mast3r_slam:
	cd $(MKFILE_DIR) && \
	$(PARAMETERS) \
	ROOT_DIR=$(MAST3R_SLAM_ROOT_DIR) \
	docker compose run mast3r_slam