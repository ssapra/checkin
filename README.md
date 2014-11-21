# checkin

[![Build Status](https://travis-ci.org/ssapra/checkin.svg)](https://travis-ci.org/ssapra/checkin)

1. [Overview](#overview)
2. [How Does It Work](#how-does-it-work)
3. [Endpoints](#endpoints)
4. [Development](#development)

### Overview

This is for Belly's Interview [Challenge](https://tech.bellycard.com/join/) where I've built a service to allow a user to check in at a merchant.

This service returns a list of merchants in order to check in at a specific merchant. The user only needs to chose the merchant and specify their email. If the email is valid and does not exist in the database, a new Person record is created in the database.

### How Does It Work

 TODO

### Endpoints

<table>
<tr>
<td>**HTTP Verb**</td>
<td>**Path**</td>
<td>**Used for**</td>
</tr>
<tr>
<td>GET</td>
<td>/merchants(.:format)</td>
<td>Get a list of merchants</td>
</tr>
</table>


### Development

```
bundle install

rake db:reset

rake db:seed

rspec spec

rackup
```
