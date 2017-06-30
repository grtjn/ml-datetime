# ml-datetime
MarkLogic library with various date/time related functions

## API Documentation

See [API.md](API.md).

## Testing

- git clone git://github.com/robwhitby/xray.git
- setup an app-server mounting current dir as modules-root on localhost 8765
- ./test.sh

## Updating docs

- install xquerydoc (see https://github.com/xquery/xquerydoc)
- run: xquerydoc -f markdown
- cp xqdoc/xqdoc_ml-datetime_datetime.xqy.md API.md
