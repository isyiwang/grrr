#!/bin/sh

should_kill = false
if [ ! -f tmp/pids/server.pid ]
then
  rails server&
  sleep 5
  should_kill = true
fi

yarn apollo-codegen introspect-schema http://localhost:3000/graphql --output schema.json && \
  yarn apollo-codegen generate app/javascript/**/*.graphql --schema schema.json \
  --target flow --output app/javascript/graphqlTypes.js

if $should_kill; then
  kill `cat tmp/pids/server.pid`
fi
