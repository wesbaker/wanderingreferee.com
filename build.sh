#!/bin/bash
set -e
hugo --baseURL "${CF_PAGES_URL:-https://wanderingreferee.com}"
