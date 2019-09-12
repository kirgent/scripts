#!/bin/bash
curl -XPOST "localhost:9200/_all/_open?allow_no_indices=true&expand_wildcards=all"
