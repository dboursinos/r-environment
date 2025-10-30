SRC_DIR := src
OUTPUT_DIR := output
R_SCRIPT := "main.R"
REPORT_NAME := "report"
REPORT_EXT := "Rmd"
REPORT_OUTPUT_NAME := "../output/p_values_report.pdf"
IMAGE_NAME := r-environment
CONTAINER_NAME := r-environment

all: build run

build:
	docker build -f ./R.Dockerfile -t r-environment .

run_report:
	docker run -it --rm --name $(CONTAINER_NAME) --user $(id -u):$(id -g) -v ${PWD}:/work r-environment R -e "rmarkdown::render('$(SRC_DIR)/$(REPORT_NAME).$(REPORT_EXT)', output_file='./output')"

run_script:
	docker run -it --rm --name $(CONTAINER_NAME) --user $(id -u):$(id -g) -v ${PWD}:/work r-environment Rscript $(SRC_DIR)/$(R_SCRIPT)

rebuild: clean build

clean:
	docker image rm -f $(IMAGE_NAME) 2>/dev/null || true
