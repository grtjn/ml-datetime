# ml-datetime
MarkLogic library with various date/time related functions

## Installation

You can install this library using [MLPM](http://registry.demo.marklogic.com/docs) with:

- mlpm install ml-datetime --save

Alternatively, you can just grab the sources from github, and add to your source tree.

## Deployment

You can deploy it using the deploy command of the same tool. In case you use slush-marklogic-node, you can also use:

- ./ml local deploy packages

And optionally enable that as part of deploy modules in deploy/app_specific.rb.

Either way, it gets installed at /ext/mlpm_modules/ml-datetime/.

In case you skipped MLPM, just use your regular deploy tool to deploy it to MarkLogic.

## Usage

Example:

    xquery version "1.0-ml";
    
    import module namespace dt = "http://marklogic.com/datetime"
      at "/ext/mlpm_modules/ml-datetime/datetime.xqy";
    
    let $html := xdmp:document-filter(doc($trgr:uri))
    let $date := dt:get-html-date($html)
    return $date/@content/dt:parse-dateTime(data(.))

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
- manually remove private vars (all) and functions (apply-*)
