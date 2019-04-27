# codeship-monitor
A simple Ruby service for cataloging codeship organization data

- A codeship API client for ruby
- A scheduler to run this API request as a routine job
- Exhaustive persisting for all organisations attched to the account

## Setup

This service can be run standalone as:

```
echo .env << "USERNAME={your codeship email}\nPASSWORD={your codeship password}"

bundle i

bundle exec ruby start.rb
```

## Works In Progress

- [ ] Logging into a database
- [ ] Integrate with Graphana
- [ ] Seperate out client library into Codeship V2 API gem
