Code used with the OHDSI queries (the queries themselves are distributed as R code downloaded from the pSCANNER sharepoint).

* **drug_era_postgres.sql** - drug era code ported from Chris Knoll's.
* **postgres_v4_condition_era.sql** - condition era code ported from Taylor Delahanty's port of Chris Knoll's code.
* **observation_period_hack.sql** - creates observation period entries based on each user's first and last visit dates.
This is not an accurate reflection of what should be in the observation_period table, but since we don't have
accurate data, we've been told to use this method for this study.
* **drug_hack.sql** - In order to get the R-generated queries to work, we had to change the types of some drug_exposure
fields from numeric to integer.

Chris Knoll's drug era code: https://gist.github.com/chrisknoll/64da3ee06b271763d1be

Taylor Delahanty's condition era code: https://gist.github.com/taylordelehanty/01fe9e92a322331a8b35
