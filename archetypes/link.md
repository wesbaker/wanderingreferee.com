+++
date = '{{ .Date }}'
draft = true
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
externalUrl = ''
summary = ''
showReadingTime = false

[build]
render = 'never'
list = 'local'
+++
