.PHONY: clean venv tables data

clean:
	@rm -rf venv

venv: clean
	@virtualenv venv -p python3
	@pip install -r requirements.txt
	@source venv/bin/activate

tables:
	@python3 src/tables.py

data:
	@python3 src/data.py
