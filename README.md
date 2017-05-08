# Queryable-API

### Description

This is an example of internal API that would be used for a national healthcare provider that has a set of inpatient prospective payment systems providers.

### API
An API is served via api/v1/providers to find a list of all providers. The following queries may be included
- max_discharges
- min_discharges
- max_average_covered_charges
- min_average_covered_charges
- max_average_medicare_payments
- min_average_medicare_payments
- state

an example looks like:
`GET /providers?min_discharges=5&max_discharges=16&max_average_covered_charges=50000
&min_average_covered_charges=40000&min_average_medicare_payments=6000
&max_average_medicare_payments=10000&state=GA`


### Getting Started

Clone this repo:

```
$ git clone git@github.com:KristaANelson/Queryable-API.git
```

Navigate into the directory:

```
$ bundle install
```

Setup the database:

```
$ rake db:setup
```

Load the database

```
$ rake load_data:insert_providers["data/impatient_prospective_payment_system_providers.csv"]
```

Start the server:

```
$ rails server
```

Visit http://locahost:3000/api/v1/providers

### Tests

To run the tests:
```
$ rake test
```

### Live Deployment
See this live at https://queryable-api.herokuapp.com/api/v1/providers

### architecture, solutions, and future improvements
- I used a standard api/v1 nesting structure in order to support new versions in the future.
I created a rake task, that pulls a csv file and loads the data into the database. If I had more time, I would add in functionality to pull from a remote file as well as a file stored locally and add a set of tests for the services.

I created a single table, providers. In order to keep page load times down, although it took little bit extra work up front I stored the querable dollar amounts as both their displayed string, as well as a converted to cents integer. If I had more time, I would add in a data cleanser that would make sure each attribute was in the correct format. For example all states would be stored in a consistent format ("CO", vs "co", vs "Co" vs "Colorado"). I would also add in more model validations based on those requirements.

### assumptions

This was was designed with the following assumptions:
- The dataset provided has already been cleansed and in correct formats.
- The dataset provided does not update frequently
- The attributes included in the csv that are not included in the JSON will most likely never be needed
- There isn't a need for a sorted return

### Deliverables
-[x] An API endpoint that implements the url ending with `/providers`
-[x] Every possible combination of query string parameters works
-[x] Some datastore is used
-[x] Your API returns valid JSON
-[x] Automated tests (i.e. tests that can be run from command line)
-[x] A writeup/README describing your architecture, solutions, and assumptions  made
