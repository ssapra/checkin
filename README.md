# checkin

[![Build Status](https://travis-ci.org/ssapra/checkin.svg)](https://travis-ci.org/ssapra/checkin)

1. [Overview](#overview)
2. [How Does It Work](#how-does-it-work)
3. [Endpoints](#endpoints)
4. [Development](#development)

### Overview

This is for Belly's Interview [Challenge](https://tech.bellycard.com/join/) where I've built a service to allow a user to check in at a merchant.

There are 3 ActiveRecord models for this application. Merchant and Person are the models that represent the two parties involved with a checkin and the Checkin model represents the join table that allows a merchant to have many people check in and a person is also able to check in with multiple merchants.

This service returns a list of merchants in order to check in at a specific merchant. The user only needs to chose the merchant and specify their email. If the email is valid and does not exist in the database, a new Person record is created in the database as well as a new Checkin record.

### How Does It Work

By running the seeds file, the application loads 92 Chicago businesses from [City of Chicago Data Portal](https://data.cityofchicago.org/Health-Human-Services/Food-Inspections/4ijn-s7e5). In order to identify which merchants are available to check in at, the user can make a GET request to /merchants. By choosing one of the listed merchant ids and also supplying the user's email, the user can check in at a particular merchant by making a POST request to /checkins.

In development, the application also sends request and database statistics to a server running on 127.0.0.1 with port 8125. For other analytics, the user can also make a GET request to /people/:id/merchants to see a list of most visited merchants.

### Endpoints

<table>
<tr>
<td>**HTTP Verb**</td>
<td>**Path**</td>
<td>**Purpose**</td>
</tr>
<tr>
<td>GET</td>
<td>/merchants</td>
<td>Get a list of merchants</td>
</tr>
<tr>
<td>POST</td>
<td>/checkins</td>
<td>Create a checkin</td>
</tr>
<tr>
<td>GET</td>
<td>/people</td>
<td>Get a list of people who have checked in before</td>
</tr>
<tr>
<td>GET</td>
<td>/people/:id</td>
<td>Get a single person</td>
</tr>
<tr>
<td>GET</td>
<td>/people/:id/merchants</td>
<td>Get a person's most visited merchants</td>
</tr>
</table>


### Development

```
bundle install

rake db:reset db:seed

rspec

rackup
```

## Resources

* [Interview question](https://tech.bellycard.com/join/): Original interview question on Belly's website
* [City of Chicago Data Portal](https://data.cityofchicago.org/Health-Human-Services/Food-Inspections/4ijn-s7e5): Public Chicago datasets
* [Grape](http://intridea.github.io/grape/): An opinionated micro-framework for creating REST-like APIs in Ruby
* [Napa](https://github.com/bellycard/napa): A simple framework for building APIs with Grape
