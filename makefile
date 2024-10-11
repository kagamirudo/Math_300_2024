# Define default directory for submission
SUBMISSION_DIR=submission

# Rule to convert a notebook to PDF and save it to the submission folder
pdf:
	@echo "Converting $(file).ipynb to PDF..."
	jupyter nbconvert --to pdf $(file).ipynb --output-dir=$(SUBMISSION_DIR)
