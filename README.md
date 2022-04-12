# QR-Shortener

- Shorten URL, editable URL
- Generate QRCode

## Dev

```
bundle install
URL_BASE=http://localhost:4567 STORAGE_PATH=data bundle exec ruby api.rb
```

## Test

```
STORAGE_PATH=./data_test bundle exec ruby test/api_test.rb
```

## Docker
```
docker-compose build
docker-compose up -d
```
