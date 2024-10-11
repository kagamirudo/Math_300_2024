# Define default directory for submission
SUBMISSION_DIR=submission

run: 
	@echo "Available: pdf, merge";
	
# Rule to convert a notebook to PDF and save it to the submission folder
pdf:
	@if [ -z "$(file)" ]; then \
		echo "Usage: make pdf file=<notebook_path>"; \
		echo "Example: make pdf file=homework/01"; \
	else \
		echo "Converting $(file).ipynb to PDF..."; \
		jupyter nbconvert --to pdf $(file).ipynb --output-dir=$(SUBMISSION_DIR); \
	fi

merge:
	@if [ -z "$(file)" ]; then \
		echo "Usage: make merge file=<pdf_file>"; \
		echo "Note: Files in submission & written same name";\
		echo "Example: make merge file=01"; \
	else \
		pdfunite submission/$(file).pdf written/$(file).pdf merge/$(file).pdf;\
	fi