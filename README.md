# nfl-playdraft-analysis

A project that looks into DRAFT's 2017 Best Ball data using Google BigQuery. The data is open-source and can be downloaded [here](https://blog.draft.com/2018/03/12/attention-nerds-2017-raw-best-ball-data/).

Two main components are included:

- Tooling to load the data into Google BigQuery (as local CSVs that have already been downloaded)
- Jupyter notebooks that analyze the data

## Loading the data

To load the data into BigQuery, follow these steps:

1. Download the data from the DRAFT blog ([here](https://blog.draft.com/2018/03/12/attention-nerds-2017-raw-best-ball-data/)).
2. Place it in a `data/` directory.
3. Ensure that the filenames in `config.yaml`'s `draft` key match those in the local directory.

```yaml
data:
  dir: ./data
  drafts_path:
    - draft_1_2017.csv
    - draft_2_2017.csv
    - draft_3_2017.csv
  leagues_path: leagues_2017.csv
  players_path: players_2017.csv
  results_path: weekly_results_2017.csv
```

4. Set up an empty project and dataset in Google BigQuery.
5. Update the `project_id` and `dataset_id` fields in `config.yaml`'s `bigquery` key to match the empty project and dataset that were created.

```yaml
bigquery:
  project_id: ad-fantasy-football
  dataset_id: playdraft
  schemas: ...
```

6. Set up the local virtual environment using `make venv`.
7. Initialize tables in BigQuery using `make tables`.
8. Populate the tables in BigQuery using `make data`.
